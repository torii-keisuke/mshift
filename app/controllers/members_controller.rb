class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @schedules = Schedule.where(event_id: @event.id)
  end
end
