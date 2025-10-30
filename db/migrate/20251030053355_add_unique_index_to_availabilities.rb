class AddUniqueIndexToAvailabilities < ActiveRecord::Migration[8.1] # Ou a versão do seu Rails
  def change
    remove_index :availabilities, :user_id, if_exists: true
    remove_index :availabilities, :time_slot_id, if_exists: true

    add_index :availabilities, [:user_id, :time_slot_id], unique: true
  end
end