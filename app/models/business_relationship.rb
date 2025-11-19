class BusinessRelationship < ApplicationRecord
  belongs_to :follower, polymorphic: true
  belongs_to :followed, polymorphic: true

  validates :follower_id, :follower_type, :followed_id, :followed_type, presence: true
  validates :follower_id, uniqueness: { scope: [:followed_id, :follower_type, :followed_type] }
end