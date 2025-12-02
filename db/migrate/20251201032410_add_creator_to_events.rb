class AddCreatorToEvents < ActiveRecord::Migration[8.1]
  def change
    add_reference :events, :creator, polymorphic: true, null: false
  end
end
