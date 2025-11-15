class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.references :business_address, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.integer :points_rewarded

      t.timestamps
    end
  end
end
