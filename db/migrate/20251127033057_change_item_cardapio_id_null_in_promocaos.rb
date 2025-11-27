class ChangeItemCardapioIdNullInPromocaos < ActiveRecord::Migration[7.0]
  def change
    change_column_null :promocaos, :item_cardapio_id, true
  end
end
