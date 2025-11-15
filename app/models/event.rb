class Event < ApplicationRecord
  belongs_to :business_address

  has_many :event_participations, dependent: :destroy
  has_many :participants, through: :event_participations, source: :user

  validates :name, presence: true
  validates :start_time, presence: true
  validates :points_rewarded, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
end
