FactoryBot.define do
  factory :item_cardapio do
    nome { "Item Teste" }
    descricao { "Descrição do item teste" }
    preco { 25.50 }
    tipo { 0 } # comida
    worth { 10 }
    association :cardapio
  end
end
