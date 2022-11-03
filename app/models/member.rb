class Member < ApplicationRecord

  belongs_to :event

  # validates :grade, inclusion: { in: Member.grades.keys }

  scope :available, -> (event_id, schedule_id) { ((where(event_id: event_id).pluck(:id)) - (MembersSchedule.where(schedule_id: schedule_id).pluck(:member_id)) - (Shift.where(schedule_id: (schedule_id - 1)).pluck(:member_id)) - (Shift.where(schedule_id: (schedule_id + 1)).pluck(:member_id)) - (Shift.where(schedule_id: schedule_id).pluck(:member_id))) }

  def self.import(file, event_id)
    Member.transaction do
      xlsx = Roo::Excelx.new(file.tempfile)
      xlsx.each_row_streaming(offset: 1) do |row|
        member = self.new(department: row[1]&.value, grade: row[2]&.value, name: row[3]&.value, position: row[4]&.value, event_id: event_id)
        next if self.pluck(:id).include?(member.id)
        member.save
      end
    end
  end
end
