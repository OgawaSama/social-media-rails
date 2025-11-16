class ItemCardapio < ApplicationRecord
  belongs_to :cardapio
  has_many :promocoes, class_name: "Promocao", dependent: :destroy
  has_many :item_cardapio_comments, dependent: :destroy
  has_many :item_rates, dependent: :destroy
  has_many :users, through: :item_rates

  # enum tipo: { comida: 0, bebida: 1 } --> quebrado nao sei porque abaixo fix temporario
  TIPO = { comida: 0, bebida: 1 }

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tipo, presence: true
end
