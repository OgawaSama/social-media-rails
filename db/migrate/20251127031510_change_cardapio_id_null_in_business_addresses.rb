class ChangeCardapioIdNullInBusinessAddresses < ActiveRecord::Migration[8.1]
  def change
    change_column_null :business_addresses, :cardapio_id, true
  end
end