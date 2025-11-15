class CreateBusinessComments < ActiveRecord::Migration[8.1]
  def change
    create_table :business_comments do |t|
      t.references :business, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: "consumer" # "consumer" or "critic"

      t.timestamps
    end
  end
end
