class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :creator, polymorphic: true, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
