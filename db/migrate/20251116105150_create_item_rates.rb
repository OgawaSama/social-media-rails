class CreateItemRates < ActiveRecord::Migration[8.1]
  def change
    create_table :item_rates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item_cardapio, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end

    add_index :item_rates, [ :user_id, :item_cardapio_id ], unique: true
  end
end
