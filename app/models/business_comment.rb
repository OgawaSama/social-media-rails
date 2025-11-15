class BusinessComment < ApplicationRecord
  belongs_to :business
  belongs_to :user

  validates :role, presence: true, inclusion: { in: %w[consumer critic] }

  has_rich_text :body
end
