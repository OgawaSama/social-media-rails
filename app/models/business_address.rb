class BusinessAddress < ApplicationRecord
  belongs_to :business
  validates :street, :city, :state, :zip, presence: true

  has_one :cardapio, dependent: :destroy
end
