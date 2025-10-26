class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  after_commit :resize_attachments_later, on: [:create, :update]

  private

  def resize_attachments_later
    [avatar, header].each do |attachment|
      next unless attachment.attached? && attachment.variable?

      ResizeProfileImageJob.perform_later(attachment.blob.id)
    end
  end
end
