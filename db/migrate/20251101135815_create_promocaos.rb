class CreatePromocaos < ActiveRecord::Migration[8.1]
  def change
    create_table :promocaos do |t|
      t.string :titulo
      t.text :descricao
      t.decimal :desconto, precision: 5, scale: 2
      t.references :cardapio, null: false, foreign_key: true
      t.references :item_cardapio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
