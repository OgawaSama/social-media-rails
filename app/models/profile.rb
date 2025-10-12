class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  def bio_limit_char
    char_limit = 512
    bio&.bio&.to_plain_text&.first(char_limit)
  end
end
