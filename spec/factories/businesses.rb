FactoryBot.define do
  factory :business do
    user
    company_name { "Riot Games" }
    cnpj { 15409786000172 }
  end
end
