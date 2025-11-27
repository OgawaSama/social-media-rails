class Profile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :header
  has_one_attached :avatar

  validate :acceptable_files

  # MUDANÇA 1: Usamos after_save para detetar a mudança antes que ela limpe
  after_save :check_for_attachment_changes
  
  # MUDANÇA 2: Usamos after_commit apenas para agendar o job
  after_commit :resize_attachments_later, on: [:create, :update]

  def bio_limit_char
    char_limit = 512
    bio&.to_plain_text&.first(char_limit)
  end


  private

  # Método para detetar se houve upload (funciona mesmo se o blob já existir)
  def check_for_attachment_changes
    # 'attachment_changes' é um hash interno do ActiveStorage que guarda as mudanças pendentes
    @avatar_changed = attachment_changes['avatar'].present?
    @header_changed = attachment_changes['header'].present?
  end

  def resize_attachments_later
    # Se o avatar mudou E é válido, agenda o job
    if @avatar_changed && avatar.attached? && avatar.variable?
      ResizeProfileImageJob.perform_later(avatar.blob)
    end

    # Se o header mudou E é válido, agenda o job
    if @header_changed && header.attached? && header.variable?
      ResizeProfileImageJob.perform_later(header.blob)
    end
    
    # Limpa as flags para evitar falsos positivos futuros na mesma instância
    @avatar_changed = false
    @header_changed = false
  end

  # ... (teus métodos acceptable_files e purge_invalid_attachments mantêm-se iguais) ...
  def acceptable_files
    [ avatar, header ].each do |attachment|
      next unless attachment.attached?

      unless attachment.content_type.in?(%w[image/jpeg image/png image/gif video/mp4 video/mpeg video/quicktime])
        errors.add(:base, "Os arquivos do perfil devem ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)")
        attachment.instance_variable_set(:@should_purge, true)
      end
    end
  end

  after_validation :purge_invalid_attachments, if: -> { errors.any? }

  def purge_invalid_attachments
    [ avatar, header ].each do |attachment|
      next unless attachment.attached? && attachment.instance_variable_get(:@should_purge)
      attachment.purge
    end
  end
end