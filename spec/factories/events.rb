FactoryBot.define do
  factory :event do
    title { "MyString" }
    description { "MyText" }
    creator { nil }
    start_date { "2025-10-30" }
    end_date { "2025-10-30" }
  end
end
