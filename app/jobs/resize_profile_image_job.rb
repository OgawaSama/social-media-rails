class ResizeProfileImageJob < ApplicationJob
  queue_as :default

  def perform(attachment)
    variants_to_process = {
      thumb: { resize_to_limit: [ 150, 150 ] },
      large: { resize_to_limit: [ 1024, 1024 ] }
    }

    Rails.logger.info "ResizeProfileImageJob: Processing variants for Attachment #{attachment.id}..."

    variants_to_process.each do |key, transformations|
      attachment.variant(transformations).processed

      Rails.logger.info "ResizeProfileImageJob: Variant ':#{key}' processed."
    end

  rescue ActiveStorage::IntegrityError
    Rails.logger.warn "ResizeProfileImageJob: Failed to process attachment #{attachment.id} (IntegrityError). File may be missing."
  end
end
