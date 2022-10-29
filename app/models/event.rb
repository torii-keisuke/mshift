class Event < ApplicationRecord

  belongs_to :user
  has_many :works, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :schedules, dependent: :destroy

  enum interval: { thirty_munites: 0, one_hour: 1, one_point_five_hours: 2, two_hours: 3 }
end
