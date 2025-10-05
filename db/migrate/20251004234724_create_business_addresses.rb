class CreateBusinessAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :business_addresses do |t|
      t.references :business, null: false, foreign_key: true
      t.string :street
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
