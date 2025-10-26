class ResizeProfileImageJob < ApplicationJob
  queue_as :default

  def perform(blob_id)
    blob = ActiveStorage::Blob.find(blob_id)
    attachment = blob.attachments.first

    return unless attachment&.attached?

    resized = ImageProcessing::MiniMagick
      .source(blob.download)
      .resize_to_limit(800, 800)
      .call

    attachment.attach(
      io: File.open(resized.path),
      filename: blob.filename.to_s,
      content_type: blob.content_type
    )

    resized.close!
  end
end
