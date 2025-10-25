class Group < ApplicationRecord
  has_many :group_participations, dependent: :destroy
  has_many :participants, through: :group_participations, source: :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  before_save :resize_attachments

  def owner
    group_participations.ownerships.map(&:user).first
  end

  def feed
    Post.where(user_id: participant_ids + [ id ]).order(created_at: :desc)
  end

  private

  def resize_attachments
    resize_image(avatar) if avatar.attached?
    resize_image(header) if header.attached?
  end

  def resize_image(attachment)
    resized = ImageProcessing::MiniMagick
      .source(attachment.download)
      .resize_to_limit(800, 800)
      .call

    attachment.attach(
      io: File.open(resized.path),
      filename: attachment.filename.to_s,
      content_type: attachment.content_type
    )
  end
end
