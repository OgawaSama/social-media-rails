FactoryBot.define do
  factory :item_cardapio do
    cardapio
    sequence(:nome) { |n| "item #{n}" }
    sequence(:descricao) { |n| "Descrição do item #{n}" }
    preco { 9.99 }
    tipo { 0 }
  end
end
