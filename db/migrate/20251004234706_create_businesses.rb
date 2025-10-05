class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.string :cnpj

      t.timestamps
    end
  end
end
