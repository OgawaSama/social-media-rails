class AddDefaultRatingToBusiness < ActiveRecord::Migration[8.1]
  def change
    change_column :businesses, :rating, :float, default: 0.0
  end
end
