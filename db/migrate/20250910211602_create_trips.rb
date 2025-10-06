class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.string :destination
      t.string :date

      t.timestamps
    end
  end
end
