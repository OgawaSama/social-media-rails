class CreateCardapios < ActiveRecord::Migration[8.0]
  def change
    create_table :cardapios do |t|
      t.references :business, null: false, foreign_key: true
      t.string :titulo

      t.timestamps
    end
  end
end
