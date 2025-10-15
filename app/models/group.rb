class Group < ApplicationRecord
  has_many :group_participations, dependent: :destroy
  has_many :participants, through: :group_participations, source: :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  validates :avatar, content_type: { in: [ :png, :jpeg ], spoofing_protection: true }
  validates :header, content_type: { in: [ :png, :jpeg ], spoofing_protection: true }

  def owner
    group_participations.ownerships.map(&:user).first
  end

  def feed
    Post.where(user_id: participant_ids + [ id ]).order(created_at: :desc)
  end
end
