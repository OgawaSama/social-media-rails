class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :images, content_type: { in: [ :png, :jpeg ], spoofing_protection: true }


  # Redimensiona imagens após criar ou atualizar o post
  attr_accessor :resizing_images

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

  private

  def resize_images_later
    images.each do |image|
      next unless image.variable?
      ResizeImageJob.perform_later(image)
    end
  end
end
