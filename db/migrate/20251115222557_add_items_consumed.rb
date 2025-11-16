class AddItemsConsumed < ActiveRecord::Migration[8.1]
  def change
    create_table :items_consumed do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.integer :quantity, default: 1
      t.string :brand
      t.date :date
      t.integer :type, default: 0
      t.timestamps
    end
  end
end
