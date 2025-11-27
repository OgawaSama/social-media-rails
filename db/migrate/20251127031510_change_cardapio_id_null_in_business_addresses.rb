class ChangeCardapioIdNullInBusinessAddresses < ActiveRecord::Migration[7.0] # ou a tua versão
  def change
    change_column_null :business_addresses, :cardapio_id, true
  end
end