class Event < ApplicationRecord
  belongs_to :business_address, optional: true

  has_many :event_participations, dependent: :destroy
  has_many :participants, through: :event_participations, source: :user

  # Associacoes When2Meet

  belongs_to :business_address, optional: true
  belongs_to :creator, polymorphic: true, optional: true # Opcional pois eventos de business podem não ter creator direto
  has_many :time_slots, dependent: :destroy
  has_many :availabilities, through: :time_slots

  validates :name, presence: true
  validates :start_time, presence: true
  validates :points_rewarded, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
end
