class CreateItemCardapioComments < ActiveRecord::Migration[8.1]
  def change
    create_table :item_cardapio_comments do |t|
      t.references :item_cardapio, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: "consumer" # "consumer" or "critic"

      t.timestamps
    end
  end
end
