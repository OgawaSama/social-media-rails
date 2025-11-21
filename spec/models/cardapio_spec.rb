require 'rails_helper'

RSpec.describe Cardapio, type: :model do
  let(:business_address) { create(:business_address) }
  let(:cardapio) { create(:cardapio, business_address: business_address) }

  it 'business_addresses associations can belong to multiple business addresses' do
    expect(cardapio.business_address).to eq(business_address)
  end

  it 'promocoes associations can have many promocoes' do
    # Criar um item_cardapio primeiro para a promoção
    item_cardapio = create(:item_cardapio, cardapio: cardapio)
    # Criar promoção associada ao cardápio
    promocao = create(:promocao, cardapio: cardapio, item_cardapio: item_cardapio)
    expect(cardapio.promocoes).to include(promocao)
  end
end
