class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  # Validação dos tipos de arquivo
  validate :acceptable_files

  after_commit :resize_attachments_later, on: [:create, :update]

  private

  def acceptable_files
    [avatar, header].each do |attachment|
      next unless attachment.attached?

      unless attachment.content_type.in?(%w[image/jpeg image/png image/gif video/mp4 video/mpeg video/quicktime])
        errors.add(:base, "Os arquivos do perfil devem ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)")
        attachment.purge 
      end
    end
  end

  def resize_attachments_later
    [avatar, header].each do |attachment|
      next unless attachment.attached? && attachment.variable?

      ResizeProfileImageJob.perform_later(attachment.blob.id)
    end
  end
end