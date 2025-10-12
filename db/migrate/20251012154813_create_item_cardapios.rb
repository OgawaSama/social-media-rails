class CreateItemCardapios < ActiveRecord::Migration[8.0]
  def change
    create_table :item_cardapios do |t|
      t.references :cardapio, null: false, foreign_key: true
      t.string :nome
      t.text :descricao
      t.decimal :preco
      t.integer :tipo

      t.timestamps
    end
  end
end
