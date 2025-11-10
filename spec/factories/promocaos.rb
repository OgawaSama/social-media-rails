FactoryBot.define do
  factory :promocao do
    titulo { "MyString" }
    descricao { "MyText" }
    desconto { "9.99" }
    cardapio { nil }
    item_cardapio { nil }
  end
end
