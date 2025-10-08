class Group < ApplicationRecord
  has_many :group_participations, dependent: :destroy
  has_many :participants, :through => :group_participations , :source => :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  def owner
    group_participations.ownerships.map(&:user).first
  end
end
