class MakeBusinessAddressOptional < ActiveRecord::Migration[7.1]
  def change
    # Permite que a coluna business_address_id fique vazia (nula)
    change_column_null :events, :business_address_id, true
  end
end
