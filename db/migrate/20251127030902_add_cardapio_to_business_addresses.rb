class AddCardapioToBusinessAddresses < ActiveRecord::Migration[8.1]
  def change
    add_reference :business_addresses, :cardapio, null: false, foreign_key: true
  end
end
