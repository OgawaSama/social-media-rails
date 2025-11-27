require 'rails_helper'

RSpec.describe ResizeImageJob, type: :job do
  include ActiveJob::TestHelper

  # Helper para criar um blob usando o vosso caminho de fixtures
  let(:image_blob) do
    ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'valid_avatar.png')),
      filename: 'valid_avatar.png',
      content_type: 'image/png'
    )
  end

it 'executa o processamento das variantes definidas no blob' do
    processed_variant = instance_double(ActiveStorage::Variant, processed: true)
    
    # --- CORREÇÃO (Falha 1) ---
    # Usamos hash_including para não depender da ordem
    allow(image_blob).to receive(:variant).with(hash_including(resize_to_limit: [200, 200])).and_return(processed_variant)
    allow(image_blob).to receive(:variant).with(hash_including(resize_to_limit: [800, 800])).and_return(processed_variant)
    
    expect(processed_variant).to receive(:processed).twice
    ResizeImageJob.perform_now(image_blob)
  end

  it 'NÃO cria um novo Blob no ActiveStorage' do
    # --- CORREÇÃO (Falha 2) ---
    # Adicionar este mock para evitar o LoadError do vips
    processed_variant = instance_double(ActiveStorage::Variant, processed: true)
    allow(image_blob).to receive(:variant).and_return(processed_variant)
    
    expect {
      ResizeImageJob.perform_now(image_blob)
    }.not_to change(ActiveStorage::Blob, :count)
  end

  it 'NÃO enfileira nenhum job adicional (evita loops)' do
    # --- CORREÇÃO (Falha 3) ---
    # Adicionar este mock para evitar o LoadError do vips
    processed_variant = instance_double(ActiveStorage::Variant, processed: true)
    allow(image_blob).to receive(:variant).and_return(processed_variant)
    
    expect {
      ResizeImageJob.perform_now(image_blob)
    }.not_to have_enqueued_job
  end

  it 'lida graciosamente se o blob for purgado antes da execução' do
    allow(image_blob).to receive(:variant).and_raise(ActiveStorage::IntegrityError)

    expect {
      ResizeImageJob.perform_now(image_blob)
    }.not_to raise_error
  end
end