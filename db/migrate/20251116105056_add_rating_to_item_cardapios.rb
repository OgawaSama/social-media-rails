class AddRatingToItemCardapios < ActiveRecord::Migration[8.1]
  def change
    add_column :item_cardapios, :rating, :float, default: 0.0
  end
end
