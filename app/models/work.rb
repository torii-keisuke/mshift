class Work < ApplicationRecord

  belongs_to :event

  validates :name, presence: true

  def self.import(file, event_id)
    Member.transaction do
      xlsx = Roo::Excelx.new(file.tempfile)
      xlsx.each_row_streaming(offset: 1) do |row|
        work = self.new(name: row[1]&.value, event_id: event_id)
        next if self.pluck(:id).include?(work.id)
        work.save
      end
    end
  end
end
