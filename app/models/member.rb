class Member < ApplicationRecord

  belongs_to :event

  # validates :grade, inclusion: { in: Member.grades.keys }

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
