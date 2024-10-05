class MembersSchedulesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @event = Event.find(params[:event_id])
  #   @q = Member.preload(:event).where(event_id: @event.id).ransack(params[:q])
  #   @members = @q.result
  #   @schedules = Schedule.preload(:event).where(event_id: @event.id)
  #   @members_schedules = MembersSchedule.preload(:event).where(event_id: @event.id)
  # end

  def index
    @event = Event.find(params[:event_id])

    # メンバーのクエリを効率化し、Eager Loadingを適用
    @q = Member.includes(:event).where(event_id: @event.id).ransack(params[:q])
    @members = @q.result

    # スケジュールもEager Loadingを適用
    @schedules = @event.schedules
    @members_schedules = @event.members_schedules
  end

  def create
    event = Event.find(params[:event_id])
    time_zones = params[:schedule_ids]
    time_zones&.each do |time_zone|
      MembersSchedule.create(member_id: time_zone.split[0], schedule_id: time_zone.split[1], event_id: event.id)
    end
    flash[:notice] = "スタッフのシフトを設定しました"
    redirect_to user_event_members_schedules_path(current_user.id, event.id)
  end

  def edit_members_schedules
    @event = Event.find(params[:event_id])
    @schedules = Schedule.preload(:event).where(event_id: @event.id)
    @q = Member.preload(:event).where(event_id: @event.id).ransack(params[:q])
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
    flash[:notice] = "スタッフのシフト設定を削除しました"
    redirect_to edit_members_schedules_user_event_members_schedules_path(current_user.id, event.id)
  end
end
