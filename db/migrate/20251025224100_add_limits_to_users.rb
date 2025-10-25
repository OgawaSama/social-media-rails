class AddLimitsToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :username, :string, limit: 20
    change_column :users, :first_name, :string, limit: 30
    change_column :users, :surnames, :string, limit: 50
    change_column :users, :encrypted_password, :string, limit: 128
  end
end
