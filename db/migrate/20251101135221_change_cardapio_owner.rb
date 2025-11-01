class ChangeCardapioOwner < ActiveRecord::Migration[8.1]
  def change
    remove_reference :cardapios, :business, foreign_key: true
    add_reference :cardapios, :business_address, foreign_key: true
  end
end
