FactoryBot.define do
    factory :user, aliases: [:follower, :followed] do
        sequence(:username) { |n| "user_#{n}" }
        first_name { "Flandre" }
        surnames { "Scarlet Touhou" }
        sequence(:email) { |n| "user_#{n}@mail" }
        password { "password" }
        encrypted_password { "password" }
    end
end
