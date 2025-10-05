class Friendship < ApplicationRecord
  validates :user_id, uniqueness: { scope: :other_user_id, message: "Friendship already exists between these two users." }
  belongs_to :user
  belongs_to :other_user, class_name: "User"
end
