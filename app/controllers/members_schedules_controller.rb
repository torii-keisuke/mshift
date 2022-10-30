class MembersSchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @members = Member.where(event_id: @event.id)
    @member = Member.new
    @schedules = Schedule.where(event_id: @event.id)
  end

  def create
    event = Event.find(params[:event_id])
    time_zones = params[:schedule_ids]
    time_zones&.each do |time_zone|
      MembersSchedule.create(member_id: time_zone.split[0], schedule_id: time_zone.split[1], event_id: event.id )
    end
    redirect_to user_event_members_schedules_path(current_user.id, event.id)
  end

  def edit_members_schedules
    @event = Event.find(params[:event_id])
    @schedules = Schedule.where(event_id: @event.id)
    @members = Member.where(event_id: @event.id)
  end

  def destroy
    event = Event.find(params[:event_id])
    time_zone = MembersSchedule.find_by(member_id: params[:id], schedule_id: params[:format])
    if time_zone.destroy!
      redirect_to edit_members_schedules_user_event_members_schedules_path(current_user.id, event.id)
    else
      render action: :edit_members_schedules
    end
  end
end
