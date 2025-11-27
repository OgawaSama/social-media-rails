require 'rails_helper'

RSpec.describe Profile, type: :model do
  include ActiveJob::TestHelper

  before(:each) do
    @user = build(:user)
    @profile = build(:profile, user: @user)
  end


  it "checks for user ownership" do
    expect(@profile.user).to eq(@user)

    @profile.user = nil
    expect(@profile).not_to be_valid
  end

  it "checks for valid bio" do
    # [Bookmark]
    # Add when having some restrictions
  end


  describe 'validações de anexo (acceptable_files)' do
    def attach_file(filename, content_type)
      {
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', filename)),
        filename: filename,
        content_type: content_type
      }
    end

    context 'com ficheiros válidos' do
      it 'aceita uma imagem PNG' do
        @profile.avatar.attach(attach_file('valid_avatar.png', 'image/png'))
        expect(@profile).to be_valid
        expect(@profile.errors[:base]).to be_empty
      end

      it 'aceita um vídeo MP4' do
        @profile.header.attach(attach_file('valid_video.mp4', 'video/mp4'))
        expect(@profile).to be_valid
        expect(@profile.errors[:base]).to be_empty
      end
    end

    context 'com ficheiros inválidos' do
      it 'rejeita um PDF e adiciona um erro' do
        @profile.avatar.attach(attach_file('pdf.pdf', 'application/pdf'))
        expect(@profile).not_to be_valid
        expect(@profile.errors[:base]).to include('Os arquivos do perfil devem ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)')
      end

      it 'faz o purge automático de um ficheiro inválido' do
        @profile.avatar.attach(attach_file('pdf.pdf', 'application/pdf'))

        # Espia o método 'purge'
        allow(@profile.avatar).to receive(:purge).and_call_original

        @profile.valid? # Dispara validações e callbacks de validação

        expect(@profile.avatar).to have_received(:purge)
      end

      it 'NÃO faz o purge de um ficheiro válido' do
        @profile.avatar.attach(attach_file('valid_avatar.png', 'image/png'))
        allow(@profile.avatar).to receive(:purge)

        @profile.valid?

        expect(@profile.avatar).not_to have_received(:purge)
      end
    end
  end

  describe 'callbacks de job (resize_attachments_later)' do
    def attach_image
      {
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'valid_avatar.png')),
        filename: 'valid_avatar.png',
        content_type: 'image/png'
      }
    end

      it 'enfileira o ResizeProfileImageJob quando um novo header é anexado (update)' do
        @profile.save!

        # Verificamos apenas a classe do Job, o que é suficiente e seguro.
        expect {
          @profile.header.attach(attach_image)
          @profile.save!
        }.to have_enqueued_job(ResizeProfileImageJob)
      end

    it 'NÃO enfileira o job se o blob não mudou (ex: update na bio)' do
      @profile.avatar.attach(attach_image)
      @profile.save!
      clear_enqueued_jobs # Limpa a fila

      expect {
        @profile.update!(bio: 'Este é um novo bio.')
      }.not_to have_enqueued_job(ResizeProfileImageJob)
    end
  end
end
