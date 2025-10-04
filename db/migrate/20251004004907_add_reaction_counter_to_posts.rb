class AddReactionCounterToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :reactions_count, :integer, default: 0, null: false
  end
end
