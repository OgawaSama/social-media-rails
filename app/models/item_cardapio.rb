class ItemCardapio < ApplicationRecord
  belongs_to :cardapio

  enum tipo: { comida: 0, bebida: 1 }

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tipo, presence: true
end
