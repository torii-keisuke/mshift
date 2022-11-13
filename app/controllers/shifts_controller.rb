class ShiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @schedules = Schedule.where(event_id: @event.id)
    @members = Member.where(event_id: @event.id)
    @works = Work.where(event_id: @event.id)
    @shifts = Shift.where(event_id: @event.id)
  end

  def create
    event = Event.find(params[:event_id])
    works = Work.where(event_id: event.id)
    schedules = Schedule.where(event_id: event.id)
    works.each do |work|
      schedules.each do |schedule|
        if WorksSchedule.exists?(schedule_id: schedule.id, work_id: work.id)
          shift = Shift.new(
            work_id: work.id,
            schedule_id: schedule.id,
            member_id: ((Member.where(event_id: event.id).pluck(:id)) - (MembersSchedule.where(schedule_id: schedule.id).pluck(:member_id)) - (Shift.where(schedule_id: (schedule.id - 1)).pluck(:member_id)) - (Shift.where(schedule_id: (schedule.id + 1)).pluck(:member_id)) - (Shift.where(schedule_id: schedule.id).pluck(:member_id))).sort_by{ rand }.first,
            event_id: event.id
          )
          next unless shift.save
        end
      end
    end
    flash[:notice] = "シフトを作成しました"
    redirect_to user_event_shifts_path(current_user.id, event.id)
  end

  def edit
    @event = Event.find(params[:event_id])
    @shift = Shift.find(params[:id])
    @member = Member.find(@shift.member_id)
    @schedule = Schedule.find(@shift.schedule_id)
    @work = Work.find(@shift.work_id)
    @q = @event.members.ransack(params[:q])
    @members = @q.result.pluck(:name)
  end

  def update
    shift = Shift.find(params[:id])
    event = Event.find(params[:event_id])
    member = Member.find_by(name: params[:shift][:member_name])
    if shift.update(member_id: member.id)
      flash[:notice] = "シフトを修正しました"
      redirect_to user_event_shifts_path(current_user.id, event.id)
    else
      flash.now[:alert] = "シフトの編集に失敗しました"
    end
  end

  def remove_all_shifts
    event = Event.find(params[:event_id])
    shifts = Shift.where(event_id: event.id)
    if shifts.destroy_all
      flash[:notice] = "シフトを削除しました"
      redirect_to user_event_shifts_path(current_user.id, event.id)
    else
      flash.now[:alert] = "シフトの削除に失敗しました"
      render action: :index
    end
  end
end
