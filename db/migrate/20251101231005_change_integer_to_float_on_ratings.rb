class ChangeIntegerToFloatOnRatings < ActiveRecord::Migration[8.1]
  def change
    change_column :rates, :rating, :float
  end
end
