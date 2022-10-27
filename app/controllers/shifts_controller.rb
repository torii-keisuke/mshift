class ShiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
  end
end
