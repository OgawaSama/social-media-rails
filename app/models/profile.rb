class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  validates :avatar, content_type: { in: [ :png, :jpeg ], spoofing_protection: true }
  validates :header, content_type: { in: [ :png, :jpeg ], spoofing_protection: true }

  def bio_limit_char
    char_limit = 512
    bio&.to_plain_text&.first(char_limit)
  after_commit :resize_attachments_later, on: [ :create, :update ]

  private

  def resize_attachments_later
    [ avatar, header ].each do |attachment|
      next unless attachment.attached? && attachment.variable?

      ResizeProfileImageJob.perform_later(attachment.blob.id)
    end
  end
end
