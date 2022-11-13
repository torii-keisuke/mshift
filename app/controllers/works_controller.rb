class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @works = Work.where(event_id: @event.id)
    @work = Work.new
    @schedules = Schedule.where(event_id: @event.id)
    @works_schedule = WorksSchedule.new
  end

  def create
    event = Event.find(params[:event_id])
    work = Work.new(work_params(event.id))
    if work.save
      flash[:notice] = "仕事を作成しました"
      redirect_to user_event_works_path(current_user.id, event.id)
    else
      flash.now[:alert] = "仕事の作成に失敗しました"
      render action: :index
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @work = Work.find(params[:id])
  end

  def update
    event = Event.find(params[:event_id])
    work = Work.find(params[:id])
    if work.update(work_params(event.id))
      flash[:notice] = "仕事の編集をしました"
      redirect_to user_event_works_path(current_user.id, event.id)
    else
      flash.now[:alert] = "仕事の編集に失敗しました"
      render action: :edit
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    work = Work.find(params[:id])
    if work.destroy
      flash[:notice] = "仕事を削除しました"
      redirect_to user_event_works_path(current_user.id, event.id)
    else
      flash.now[:alert] = "仕事の削除に失敗しました"
      render action: :edit
    end
  end

  private

  def work_params(event_id)
    params.require(:work).permit(:name).merge(event_id: event_id)
  end
end
