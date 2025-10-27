# app/jobs/resize_image_job.rb
class ResizeImageJob < ApplicationJob
  queue_as :default

  def perform(blob)
    return unless blob.variable?

    tempfile = Tempfile.new([ "original", File.extname(blob.filename.to_s) ])
    tempfile.binmode
    tempfile.write(blob.download)
    tempfile.rewind

    resized = ImageProcessing::MiniMagick
                .source(tempfile)
                .resize_to_limit(1000, 1000)
                .call

    # reanexa a imagem sem disparar callbacks
    record = blob.attachments.first.record
    name   = blob.attachments.first.name
    record.public_send(name).detach
    record.public_send(name).attach(
      io: File.open(resized.path),
      filename: blob.filename.to_s,
      content_type: blob.content_type
    )

    tempfile.close
    tempfile.unlink
  end
end
