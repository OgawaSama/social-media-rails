class RenameItemConsumedTypeColumn < ActiveRecord::Migration[8.1]
  def change
    rename_column :items_consumed, :type, :item_type
  end
end
