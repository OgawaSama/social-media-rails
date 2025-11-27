FactoryBot.define do
  factory :cardapio do
    titulo { "Cardápio Principal" }
    association :business_address
  end
end
