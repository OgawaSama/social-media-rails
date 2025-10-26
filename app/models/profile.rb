class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  validate :acceptable_files

  after_commit :resize_attachments_later, on: [ :create, :update ]

  private

  def acceptable_files
    [ avatar, header ].each do |attachment|
      next unless attachment.attached?

      unless attachment.content_type.in?(%w[image/jpeg image/png image/gif video/mp4 video/mpeg video/quicktime])
        errors.add(:base, "Os arquivos do perfil devem ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)")

        attachment.instance_variable_set(:@should_purge, true)
      end
    end
  end

  after_validation :purge_invalid_attachments, if: -> { errors.any? }

  def purge_invalid_attachments
    [ avatar, header ].each do |attachment|
      next unless attachment.attached? && attachment.instance_variable_get(:@should_purge)

      attachment.purge
    end
  end

  def resize_attachments_later
    [ avatar, header ].each do |attachment|
      next unless attachment.attached?
      next unless attachment.variable?
      next unless attachment.blob.present? && attachment.blob.service.exist?(attachment.key)

      ResizeProfileImageJob.perform_later(attachment.blob.id)
    end
  end
end