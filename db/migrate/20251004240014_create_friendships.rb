class CreateFriendships < ActiveRecord::Migration[8.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :other_user, null: false, foreign_key: { to_table: :users }

      t.index [ :user_id, :other_user_id ], unique: true

      t.timestamps
    end

    add_index :reactions, [ :user_id, :post_id ], unique: true
  end
end
