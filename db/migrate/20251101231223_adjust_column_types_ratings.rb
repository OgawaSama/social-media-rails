class AdjustColumnTypesRatings < ActiveRecord::Migration[8.1]
  def change
    change_column :rates, :rating, :integer
    change_column :businesses, :rating, :float
  end
end
