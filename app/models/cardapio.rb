class Cardapio < ApplicationRecord
  belongs_to :business_address
  has_many :itens_cardapio, class_name: "ItemCardapio", dependent: :destroy

  accepts_nested_attributes_for :itens_cardapio, allow_destroy: true

  has_many :promocoes, class_name: "Promocao", dependent: :destroy

  validates :titulo, presence: true
end
