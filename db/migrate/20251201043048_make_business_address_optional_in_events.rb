class MakeBusinessAddressOptionalInEvents < ActiveRecord::Migration[7.1]
  def change
    # Muda a coluna 'business_address_id' da tabela 'events' para aceitar valores nulos (null: true)
    change_column_null :events, :business_address_id, true
  end
end
