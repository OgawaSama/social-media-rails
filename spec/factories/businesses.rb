FactoryBot.define do
  factory :business do
    company_name { "Bar Teste" }
    cnpj { "12.345.678/0001-90" }
    business_type { "bar" }
    rating { 0.0 }
    association :user, factory: :user

    trait :restaurant do
      company_name { "Restaurante Teste" }
      business_type { "restaurant" }
    end

    trait :cafe do
      company_name { "Café Teste" }
      business_type { "cafe" }
    end

    trait :store do
      company_name { "Loja Teste" }
      business_type { "store" }
    end

    trait :wine_shop do
      company_name { "Wine Shop" }
      business_type { "store" }
      rating { 4.5 }
    end

    trait :with_address do
      after(:create) do |business|
        create(:business_address, business: business)
      end
    end

    trait :with_complete_setup do
      after(:create) do |business|
        address = create(:business_address, business: business)
        cardapio = create(:cardapio, business_address: address)
        create(:item_cardapio, cardapio: cardapio, nome: "Vinho")
      end
    end
  end
end
