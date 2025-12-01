class AddUniqueIndexToAvailabilities < ActiveRecord::Migration[8.1]
  def change
    add_index :availabilities, [ :user_id, :time_slot_id ], unique: true
  end
end
