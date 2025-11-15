class AddCriticToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :critic, :boolean, null: false, default: false
  end
end
