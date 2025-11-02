class AddRatingsToBusiness < ActiveRecord::Migration[8.1]
  def change
    add_column :businesses, :rating, :integer, default: "0"
  end
end
