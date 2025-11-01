FactoryBot.define do
  factory :item_cardapio do
    nome { "Item de teste" }
    descricao { "Descrição do item" }
    preco { 9.99 }
    tipo { 0 }
    cardapio
  end
end
