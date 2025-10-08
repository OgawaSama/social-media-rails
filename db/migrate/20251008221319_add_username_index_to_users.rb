class AddUsernameIndexToUsers < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :username, name: "index_users_on_username", unique: true
  end
end
