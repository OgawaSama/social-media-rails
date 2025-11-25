require 'rails_helper'

RSpec.describe ItemCardapio, type: :model do
  let(:cardapio) { create(:cardapio) }
  let(:item_cardapio) { create(:item_cardapio, cardapio: cardapio) }

  it 'belongs to a cardapio' do
    expect(item_cardapio.cardapio).to eq(cardapio)
  end

  it 'can have multiple promocoes' do
    # Criar promoção associada ao item_cardapio
    promocao = create(:promocao, item_cardapio: item_cardapio, cardapio: cardapio)
    expect(item_cardapio.promocoes).to include(promocao)
  end
end
