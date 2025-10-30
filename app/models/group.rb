class Group < ApplicationRecord
  has_many :group_participations, dependent: :destroy
  has_many :participants, through: :group_participations, source: :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  has_many :created_events, class_name: 'Event', as: :creator
  has_many :event_invitations, as: :invitee
  has_many :invited_events, through: :event_invitations, source: :event

  validates :avatar, content_type: { in: [ :png, :jpeg, :gif ], spoofing_protection: true }
  validates :header, content_type: { in: [ :png, :jpeg, :gif ], spoofing_protection: true }
  validates :name, presence: true

  after_commit :resize_attachments_later, on: [ :create, :update ]

  def owner
    group_participations.ownerships.map(&:user).first
  end

  def feed
    Post.where(user_id: participant_ids + [ id ]).order(created_at: :desc)
  end

  private

  def resize_attachments_later
    [ avatar, header ].each do |attachment|
      next unless attachment.attached? && attachment.variable?
      ResizeImageJob.perform_later(attachment.blob)
    end
  end
end
