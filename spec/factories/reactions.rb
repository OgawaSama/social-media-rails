FactoryBot.define do
  factory :reaction do
    name { "heart" }
    user
    post
  end
end
