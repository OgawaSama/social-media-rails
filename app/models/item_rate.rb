class ItemRate < ApplicationRecord
  belongs_to :user
  belongs_to :item_cardapio

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
