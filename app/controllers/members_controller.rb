class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @members = Member.where(event_id: @event.id)
    @member = Member.new
    @schedules = Schedule.where(event_id: @event.id)
  end

  def import
    event = Event.find(params[:event_id])
    file = params[:file]
    if params[:file].nil?
      file = params[:member][:file]
    else
      file = params[:file]
    end
    Member.import(file, event.id)
    redirect_to user_event_members_path(current_user.id, event.id)
  end

  def create
    event = Event.find(params[:event_id])
    member = Member.new(member_params(event.id))
    if member.save
      redirect_to user_event_members_path(current_user.id, event.id)
    else
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
      redirect_to user_event_members_path(current_user.id, @event.id)
    else
      render action: :edit
    end
  end

  def destroy

  end

  private

  def member_params(event_id)
    params.require(:member).permit(:name, :grade, :department, :position).merge(event_id: event_id)
  end
end
