class ResizeProfileImageJob < ApplicationJob
  queue_as :default
  def perform(blob)
    variants_to_process = {
      thumb: { resize_to_limit: [ 150, 150 ] },
      large: { resize_to_limit: [ 1024, 1024 ] }
    }

    Rails.logger.info "ResizeProfileImageJob: Processing variants for Blob #{blob.id}..."

    variants_to_process.each do |key, transformations|
      blob.variant(transformations).processed

      Rails.logger.info "ResizeProfileImageJob: Variant ':#{key}' processed."
    end

  rescue ActiveStorage::IntegrityError
    Rails.logger.warn "ResizeProfileImageJob: Failed to process blob #{blob.id} (IntegrityError). File may be missing."
  end
end
