FactoryBot.define do
  factory :profile do
    user
    bio { "awesomesauce" }

    after(:build) do |profile|
      profile.avatar.attach(
          io: File.open(Rails.root.join('test', 'fixtures', 'files', 'image', 'image.png')),
          filename: 'image.png',
          content_type: 'image/png'
      )
      profile.header.attach(
          io: File.open(Rails.root.join('test', 'fixtures', 'files', 'image', 'image.png')),
          filename: 'image.png',
          content_type: 'image/png'
      )
    end
  end
end
