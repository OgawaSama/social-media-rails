class Cardapio < ApplicationRecord
  belongs_to :business
  has_many :itens_cardapio, dependent: :destroy

  validates :titulo, presence: true
end
