class ItemCardapioComment < ApplicationRecord
  belongs_to :item_cardapio
  belongs_to :user

  validates :role, presence: true, inclusion: { in: %w[consumer critic] }

  has_rich_text :body
end
