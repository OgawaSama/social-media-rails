class AddBusinessTypeToBusinesses < ActiveRecord::Migration[8.1]
  def change
    add_column :businesses, :business_type, :string, default: 'other'
    add_index :businesses, :business_type
  end
end
