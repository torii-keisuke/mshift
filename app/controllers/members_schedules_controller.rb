class MembersSchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @q = Member.where(event_id: @event.id).ransack(params[:q])
    @members = @q.result
    @member = Member.new
    @schedules = Schedule.where(event_id: @event.id)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    event = Event.find(params[:event_id])
    time_zones = params[:schedule_ids]
    time_zones&.each do |time_zone|
      MembersSchedule.create(member_id: time_zone.split[0], schedule_id: time_zone.split[1], event_id: event.id)
    end
    redirect_to user_event_members_schedules_path(current_user.id, event.id)
  end

  def edit_members_schedules
    @event = Event.find(params[:event_id])
    @schedules = Schedule.where(event_id: @event.id)
    @q = Member.where(event_id: @event.id).ransack(params[:q])
    @members = @q.result
  end

  def destroy_together
    event = Event.find(params[:event_id])
    time_zones = params[:members_schedule_ids]
    ActiveRecord::Base.transaction do
      time_zones.each do |time_zone|
        members_schedule = MembersSchedule.find_by(member_id: time_zone.split[0], schedule_id: time_zone.split[1], event_id: event.id)
        members_schedule.destroy!
      end
    end
    redirect_to edit_members_schedules_user_event_members_schedules_path(current_user.id, event.id)
  end
end
