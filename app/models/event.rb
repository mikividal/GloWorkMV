class Event < ApplicationRecord

  validates :event_name, presence: true
  validates :event_date, presence: true
  validates :event_time, presence: true

  belongs_to :user

end
