FactoryBot.define do
  factory :business_relationship do
    association :follower, factory: :user
    association :followed, factory: :business

    trait :business_following_business do
      association :follower, factory: :business
      association :followed, factory: :business
    end
  end
end
