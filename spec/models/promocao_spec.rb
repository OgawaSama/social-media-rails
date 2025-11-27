require 'rails_helper'

RSpec.describe Promocao, type: :model do
  let(:cardapio) { create(:cardapio) }
  let(:item_cardapio) { create(:item_cardapio, cardapio: cardapio) }

  it 'can belong to a cardapio' do
    # Criar promoção com cardápio E item_cardapio (ambos são válidos)
    promocao = create(:promocao, cardapio: cardapio, item_cardapio: item_cardapio)
    expect(promocao.cardapio).to eq(cardapio)
    expect(promocao).to be_valid
  end

  it 'can belong to an item_cardapio' do
    # Criar promoção com cardápio E item_cardapio (ambos são válidos)
    promocao = create(:promocao, item_cardapio: item_cardapio, cardapio: cardapio)
    expect(promocao.item_cardapio).to eq(item_cardapio)
    expect(promocao).to be_valid
  end
end
