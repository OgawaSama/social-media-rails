class ResizeImageJob < ApplicationJob
  queue_as :default


  def perform(blob)
    variants_to_process = {
      thumb: { resize_to_limit: [ 200, 200 ] },
      medium: { resize_to_limit: [ 800, 800 ] }
    }

    Rails.logger.info "ResizeImageJob: Processing variants for Blob #{blob.id}..."

    variants_to_process.each do |key, transformations|
      blob.variant(transformations).processed
      Rails.logger.info "ResizeImageJob: Variant ':#{key}' processed."
    end

  rescue ActiveStorage::IntegrityError
    Rails.logger.warn "ResizeImageJob: Failed to process blob #{blob.id} (IntegrityError). File may be missing."
  end
end
