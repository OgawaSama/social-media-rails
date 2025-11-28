require 'rails_helper'

RSpec.describe Post, type: :model do
  include ActiveJob::TestHelper

  before(:each) do
    @user = build(:user)
    @post = build(:post, user: @user)
  end


  it "checks for user ownership" do
    expect(@post.user).to eq(@user)

    @post.user = nil
    expect(@post).not_to be_valid
  end

  it "checks for valid caption" do
    # [Bookmark]
    # Add when having some restrictions
  end

  it "checks for valid body" do
    # [Bookmark]
    # Add when having some restrictions
  end

  describe 'validações de anexo (acceptable_images)' do
    def attach_file(filename, content_type)
      {
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', filename)),
        filename: filename,
        content_type: content_type
      }
    end

    it 'aceita imagens válidas' do
      @post.images.attach(attach_file('valid_avatar.png', 'image/png'))
      expect(@post).to be_valid
    end

    it 'aceita vídeos válidos' do
      @post.images.attach(attach_file('valid_video.mp4', 'video/mp4'))
      expect(@post).to be_valid
    end

    it 'rejeita um PDF e adiciona um erro' do
      @post.images.attach(attach_file('pdf.pdf', 'application/pdf'))
      expect(@post).not_to be_valid
      expect(@post.errors[:images]).to include('precisam ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)')
    end


    it 'faz o purge automático de um ficheiro inválido' do
      @post.images.attach(attach_file('pdf.pdf', 'application/pdf'))

      # Em vez de espiar uma instância específica, esperamos que QUALQUER anexo receba purge
      expect_any_instance_of(ActiveStorage::Attachment).to receive(:purge)

      @post.valid?
    end
  end

  # Bloco completo de testes de job
  describe 'callbacks de job (resize_images_later)' do
    def attach_image
      {
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'valid_avatar.png')),
        filename: 'valid_avatar.png',
        content_type: 'image/png'
      }
    end

    it 'enfileira o ResizeImageJob para cada nova imagem' do
      @post.images.attach(attach_image)

      expect {
        @post.save!
      }.to have_enqueued_job(ResizeImageJob).with(@post.images.first.blob)
    end

    it 'NÃO enfileira o job se o anexo não for novo' do
      @post.images.attach(attach_image)
      @post.save!
      clear_enqueued_jobs

      expect {
        @post.update!(body: 'Update no body')
      }.not_to have_enqueued_job(ResizeImageJob)
    end
  end
end
