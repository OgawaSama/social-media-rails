FactoryBot.define do
    factory :group do
      name { "TOUHOU Project" }
      bio { "同人サークル「上海アリス幻樂団」の主宰のZUNさんが制作する、弾幕シューティングゲームとして、東方Projectが生まれました。" }

      after(:build) do |group|
        group.avatar.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'image', 'image.png')),
            filename: 'image.png',
            content_type: 'image/png'
        )
        group.header.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'image', 'image.png')),
            filename: 'image.png',
            content_type: 'image/png'
        )
        end
    end
end
