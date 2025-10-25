class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  # Limite de caracteres da bio
  def bio_limit_char
    char_limit = 512
    bio&.to_plain_text&.first(char_limit)
  end

  # Callback para redimensionar imagens antes de salvar
  before_save :resize_attachments

  private

  def resize_attachments
    resize_image(avatar) if avatar.attached?
    resize_image(header) if header.attached?
  end

  def resize_image(attachment)
    resized = ImageProcessing::MiniMagick
      .source(attachment.download)
      .resize_to_limit(800, 800) # largura/altura máxima
      .call

    attachment.attach(
      io: File.open(resized.path),
      filename: attachment.filename.to_s,
      content_type: attachment.content_type
    )
  end
end
