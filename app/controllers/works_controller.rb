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
      redirect_to user_event_works_path(current_user.id, event.id)
    else
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
      redirect_to user_event_works_path(current_user.id, event.id)
    else
      render action: :edit
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    work = Work.find(params[:id])
    if work.destroy
      redirect_to user_event_works_path(current_user.id, event.id)
    else
      render action: :edit
    end
  end

  private

  def work_params(event_id)
    params.require(:work).permit(:name).merge(event_id: event_id)
  end
end
