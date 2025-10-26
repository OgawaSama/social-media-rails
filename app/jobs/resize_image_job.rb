# app/jobs/resize_image_job.rb
class ResizeImageJob < ApplicationJob
  queue_as :default

  def perform(image_attachment)
    return unless image_attachment.variable?

    tempfile = Tempfile.new([ "original", File.extname(image_attachment.filename.to_s) ])
    tempfile.binmode
    tempfile.write(image_attachment.download)
    tempfile.rewind

    resized = ImageProcessing::MiniMagick
                .source(tempfile)
                .resize_to_limit(800, 800)
                .call

    # reanexa a imagem sem disparar callbacks
    image_attachment.record.images.detach(image_attachment)
    image_attachment.record.images.attach(
      io: File.open(resized.path),
      filename: image_attachment.filename.to_s,
      content_type: image_attachment.content_type
    )

    tempfile.close
    tempfile.unlink
  end
end
