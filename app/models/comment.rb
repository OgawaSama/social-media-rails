class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_rich_text :body
end
