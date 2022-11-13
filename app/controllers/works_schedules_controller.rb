class WorksSchedulesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    time_zones = params[:works_schedule][:schedule_ids]
    time_zones&.each do |time_zone|
      WorksSchedule.create!(work_id: time_zone.split[0], schedule_id: time_zone.split[1], event_id: event.id )
    end
    flash[:notice] = "仕事のシフトを設定しました"
    redirect_to user_event_works_path(current_user.id, event.id)
  end

  def edit_works_schedules
    @event = Event.find(params[:event_id])
    @schedules = Schedule.where(event_id: @event.id)
    @works = Work.where(event_id: @event.id)
  end

  def destroy
    event = Event.find(params[:event_id])
    time_zone = WorksSchedule.find_by(work_id: params[:id], schedule_id: params[:format])
    if time_zone.destroy!
      redirect_to edit_works_schedules_user_event_works_schedules_path(current_user.id, event.id)
    else
      render action: :edit_works_schedules
    end
  end

  def destroy_together
    event = Event.find(params[:event_id])
    time_zones = params[:works_schedule_ids]
    ActiveRecord::Base.transaction do
      time_zones.each do |time_zone|
        works_schedule = WorksSchedule.find_by(work_id: time_zone.split[0], schedule_id: time_zone.split[1], event_id: event.id)
        works_schedule.destroy!
      end
    end
    flash[:notice] = "仕事のシフト設定を削除しました"
    redirect_to edit_works_schedules_user_event_works_schedules_path(current_user.id, event.id)
  end
end
