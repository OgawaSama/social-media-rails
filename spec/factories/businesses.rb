FactoryBot.define do
  factory :business do
    user
    company_name { "Riot Games" }
    cnpj { 15409786000172 }
    rating { 0 }
    after(:create) do |business|
      create(:business_address, business: business)
    end
  end
end
