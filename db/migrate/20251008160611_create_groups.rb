class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.belongs_to :owner, null: false, foreign_key: true

      t.timestamps
    end

    create_table :group_participations, primary_key: [:user_id, :group_id] do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :group, null: false, foreign_key: true
      t.datetime :join_date

      t.timestamps 
    end

    add_index :group_participations, [ :user_id, :group_id ], unique: true 
  end
end
