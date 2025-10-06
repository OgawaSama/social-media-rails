class BusinessAddress < ApplicationRecord
  belongs_to :business
  validates :street, :city, :state, :zip, presence: true
end
