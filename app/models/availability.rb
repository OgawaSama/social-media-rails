class Availability < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot

  # Rails 7/8 Syntax (Mais segura contra conflitos)
  enum :status, { unavailable: 0, maybe: 1, available: 2 }

  validates :user_id, uniqueness: { scope: :time_slot_id }
  validates :status, presence: true
end
