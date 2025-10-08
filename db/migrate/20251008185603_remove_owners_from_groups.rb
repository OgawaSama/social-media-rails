class RemoveOwnersFromGroups < ActiveRecord::Migration[8.0]
  def change
    remove_column :groups, :owner_id
  end
end
