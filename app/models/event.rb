class Event < ApplicationRecord
  belongs_to :creator, polymorphic: true
  has_many :time_slots, dependent: :destroy
  has_many :availabilities, through: :time_slots
  has_many :event_invitations, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end