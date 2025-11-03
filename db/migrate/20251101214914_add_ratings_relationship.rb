class AddRatingsRelationship < ActiveRecord::Migration[8.1]
  def change
    create_table :rates do |t|
      t.integer :rating
      t.belongs_to :user
      t.belongs_to :business

      t.timestamps
    end

    add_index :rates, [ :user_id, :business_id ], unique: true
  end
end
