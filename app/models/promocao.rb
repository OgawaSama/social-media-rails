  class Promocao < ApplicationRecord
    belongs_to :cardapio, optional: true
    belongs_to :item_cardapio, optional: true

    validates :titulo, presence: true
    validates :desconto, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

    validate :cardapio_ou_item_presente

    private

    def cardapio_ou_item_presente
      if cardapio.nil? && item_cardapio.nil?
        errors.add(:base, "A promoção deve estar associada a um cardápio ou a um item do cardápio.")
      end
    end
  end
