module ActiveStorageHelper

  def fixture_blob(filename, content_type:)
    file_path = Rails.root.join('spec', 'fixtures', 'files', filename)
    ActiveStorage::Blob.create_and_upload!(
      io: File.open(file_path, 'rb'),
      filename: filename,
      content_type: content_type
    )
  end
end