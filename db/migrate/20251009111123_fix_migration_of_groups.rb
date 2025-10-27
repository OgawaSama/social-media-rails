class FixMigrationOfGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end

    create_table :group_participations do |t|
      t.belongs_to :group
      t.belongs_to :user
      t.datetime :join_date

      t.timestamps
    end

    add_index :group_participations, [ :user_id, :group_id ], unique: true
  end
end
