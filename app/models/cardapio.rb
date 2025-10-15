class Cardapio < ApplicationRecord
  belongs_to :business
  has_many :itens_cardapio, class_name: "ItemCardapio", dependent: :destroy

  accepts_nested_attributes_for :itens_cardapio, allow_destroy: true

  validates :titulo, presence: true
end
