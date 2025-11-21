FactoryBot.define do
  factory :promocao do
    titulo { "Promoção Teste" }
    descricao { "Descrição da promoção teste" }
    desconto { 15.0 }

    # Factory padrão cria ambos cardapio e item_cardapio para ser válido
    association :cardapio
    association :item_cardapio

    trait :only_cardapio do
      item_cardapio { nil }
    end

    trait :only_item_cardapio do
      cardapio { nil }
    end
  end
end
