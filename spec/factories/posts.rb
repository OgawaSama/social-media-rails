FactoryBot.define do
    factory :post do
        user
        caption { "this is bananas!" }
        body { "   " }

        after(:build) do |post|
            post.images.attach(
                io: File.open(Rails.root.join('test', 'fixtures', 'files', 'image', 'image.png')),
                filename: 'image.png',
                content_type: 'image/png'
            )
        end
    end
end
