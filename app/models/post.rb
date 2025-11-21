class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validate :acceptable_images

  attr_accessor :resizing_images
  def resizing_images?
    @resizing_images == true
  end

  after_commit :resize_images_later, on: :create, if: -> { images.attached? }
  def resizing_images?
    @resizing_images == true
  end

  def feed_body
    char_limit = images.any? ? 144 : 288
    body&.body&.to_plain_text&.first(char_limit)
  end

  def feed_body_truncated?
    body_chars = body&.body&.to_plain_text&.chars&.count || 0
    feed_body_count = feed_body&.chars&.count || 0
    body_chars > feed_body_count
  end

  # Scope para posts de bares
  scope :from_bars, -> {
    joins(:user)
      .where(users: { id: Business.select(:user_id) })
      .includes(user: :businesses)
  }

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
      next unless image.blob.saved_change_to_id?
      ResizeImageJob.perform_later(image.blob)
    end
  end
end
