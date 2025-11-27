FactoryBot.define do
  factory :item_cardapio do
    nome { "Item Teste" }
    descricao { "Descrição do item teste" }
    preco { 25.50 }
    tipo { 0 } # comida
    association :cardapio
  end
end
