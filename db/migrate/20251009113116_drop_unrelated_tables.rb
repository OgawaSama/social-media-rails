class DropUnrelatedTables < ActiveRecord::Migration[8.0]
  def change
    drop_table :trips
  end
end
