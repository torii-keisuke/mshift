class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.where(user_id: current_user.id)
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    if event.save
      if event.interval == "thirty_munites"
        time_interval = 1800
      elsif event.interval == "one_hour"
        time_interval = 3600
      elsif event.interval == "one_point_five_hours"
        time_interval = 5400
      elsif event.interval == "two_hours"
        time_interval = 7200
      end
      ((event.finish_time - event.start_time) / time_interval).round.times do
        Schedule.create(time_zone: event.start_time.strftime("%H:%M"), event_id: event.id)
        event.start_time += time_interval
      end
      redirect_to user_events_path(current_user.id)
    else
      render action: :index
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      redirect_to user_events_path(current_user.id)
    else
      render action: :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      redirect_to user_events_path(current_user.id)
    else
      render action: :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :opening_date, :start_time, :finish_time, :interval).merge(user_id: current_user.id)
  end
end
