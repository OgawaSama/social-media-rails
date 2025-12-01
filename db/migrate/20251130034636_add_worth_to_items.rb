class AddWorthToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items_consumed, :worth, :integer, default: 0
    add_column :item_cardapios, :worth, :integer, default: 0
  end
end
