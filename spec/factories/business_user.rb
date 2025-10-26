FactoryBot.define do
    factory :business_user, parent: :user, class: 'BusinessUser' do
      after(:create) do |business_user|
        create(:business, user: business_user)
      end
    end
end
