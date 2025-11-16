class ItemConsumed < ApplicationRecord
  belongs_to :user
  enum :item_type, [ :Beer, :Wine, :Whiskey, :Caipirinha, :Cocktail, :Sake, :Soju, :Gin, :Soda, :Water, :Garbage, :Juice, :Milk, :Other  ]

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_type, presence: true
end
