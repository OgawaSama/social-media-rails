# app/jobs/resize_image_job.rb
class ResizeImageJob < ApplicationJob
  queue_as :default

  # Recebe um ActiveStorage::Attachment
  def perform(image_attachment)
    # Define os tamanhos que queres pré-processar para Posts
    variants_to_process = {
      thumb: { resize_to_limit: [ 200, 200 ] },
      medium: { resize_to_limit: [ 800, 800 ] }
    }

    Rails.logger.info "ResizeImageJob: Processing variants for Attachment #{image_attachment.id}..."

    variants_to_process.each do |key, transformations|
      # A mesma lógica: processa a variante, não toca no modelo.
      image_attachment.variant(transformations).processed
      Rails.logger.info "ResizeImageJob: Variant ':#{key}' processed."
    end

  rescue ActiveStorage::IntegrityError
    Rails.logger.warn "ResizeImageJob: Failed to process attachment #{image_attachment.id} (IntegrityError). File may be missing."
  end
end
