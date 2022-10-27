class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @works = Work.where(event_id: @event.id)
    @work = Work.new
    @schedules = Schedule.where(event_id: @event.id)
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

  end

  def update

  end

  private

  def work_params(event_id)
    params.require(:work).permit(:name).merge(event_id: event_id)
  end
end
