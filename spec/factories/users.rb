FactoryBot.define do
    factory :user, aliases: [ :follower, :followed ] do
        sequence(:username) { |n| "user_#{n}" }
        first_name { "Flandre" }
        surnames { "Scarlet Touhou" }
        sequence(:email) { |n| "user_#{n}@mail" }
        password { "password" }
        password_confirmation { "password" }
        # encrypted_password { "password" }

        trait :business_user do
          type { "BusinessUser" }
          after(:create) do |user|
            create(:business, user: user)
          end
        end

        trait :with_profile do
          after(:create) do |user|
            create(:profile, user: user)
          end
        end
    end
end
