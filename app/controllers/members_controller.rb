class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @q = Member.where(event_id: @event.id).ransack(params[:q])
    @members = @q.result
    @member = Member.new
    @schedules = Schedule.where(event_id: @event.id)
    if params[:format] == "excel"
      template_file = "public/download_file/Mshift-テンプレ名簿-20xx年度.xlsx"
      send_file template_file
    end
  end

  def import
    event = Event.find(params[:event_id])
    file = params[:file]
    if params[:file].nil?
      file = params[:member][:file]
    else
      file = params[:file]
    end
    accept_format = ".xlsx"
    if File.extname(params[:member][:file].original_filename) == accept_format
      Member.import(file, event.id)
      flash[:notice] = "ファイルをアップロードしました"
      redirect_to user_event_members_path(current_user.id, event.id)
    else
      flash[:alert] = "ファイルのアップロードに失敗しました"
      redirect_to user_event_members_path(current_user.id, event.id)
    end
  end

  def create
    event = Event.find(params[:event_id])
    member = Member.new(member_params(event.id))
    if member.save
      flash[:notice] = "スタッフを追加しました。"
      redirect_to user_event_members_path(current_user.id, event.id)
    else
      flash.now[:alert] = "スタッフの追加に失敗しました"
      render action: :index
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @member = Member.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @member = Member.find(params[:id])
    if @member.update(member_params(@event.id))
      flash[:notice] = "スタッフの編集をしました"
      redirect_to user_event_members_path(current_user.id, @event.id)
    else
      flash.now[:alert] = "スタッフの編集に失敗しました"
      render action: :edit
    end
  end

  def destroy_together
    members = Member.where(event_id: params[:event_id])
    ActiveRecord::Base.transaction do
      members.each do |member|
        member.destroy!
      end
    end
    flash[:notice] = "スタッフを削除しました"
    redirect_to user_event_members_path(current_user.id, params[:event_id])
  end

  private

  def member_params(event_id)
    params.require(:member).permit(:name, :grade, :department, :position).merge(event_id: event_id)
  end
end
