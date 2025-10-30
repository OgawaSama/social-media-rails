class TimeSlot < ApplicationRecord
  belongs_to :event
  has_many :availabilities, dependent: :destroy
end