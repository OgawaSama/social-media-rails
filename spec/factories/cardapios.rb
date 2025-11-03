FactoryBot.define do
  factory :cardapio do
    business_address
    titulo { "Nao consigo pensar em um titulo bom" }
    after(:create) do |cardapio|
      create(:item_cardapio, cardapio: cardapio)
    end
  end
end
