class Availability < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot

  # Cria os métodos .available?, .maybe?, .unavailable?
  STATUS = { unavailable: 0, maybe: 1, available: 2 }
  validates :status, inclusion: { in: STATUS.values }, allow_nil: true

  # Garante que um usuário só pode responder uma vez por slot
  validates :user_id, uniqueness: { scope: :time_slot_id }
  validates :status, presence: true
end