FactoryBot.define do
  factory :comment do
    user
    post
    body { "so true bestie" }
  end
end
