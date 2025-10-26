class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  # Validação dos tipos de arquivo
  validate :acceptable_images

  # Redimensiona imagens após criar ou atualizar o post
  after_commit :resize_images_later, on: [ :create, :update ], unless: :resizing_images?

  def resizing_images?
    @resizing_images == true
  end

  # --- FUNÇÕES QUE A VIEW USA ---
  def feed_body
    char_limit = images.any? ? 144 : 288
    body&.body&.to_plain_text&.first(char_limit)
  end

  def feed_body_truncated?
    body_chars = body&.body&.to_plain_text&.chars&.count || 0
    feed_body_count = feed_body&.chars&.count || 0
    body_chars > feed_body_count
  end

  private

  def acceptable_images
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/gif video/mp4 video/mpeg video/quicktime])
        errors.add(:images, "precisam ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)")
        image.purge # remove o arquivo inválido antes de tentar mostrar
      end
    end
  end



  def resize_images_later
    images.each do |image|
      next unless image.variable?
      ResizeImageJob.perform_later(image)
    end
  end
end
