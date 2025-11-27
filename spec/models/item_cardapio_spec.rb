require 'rails_helper'

RSpec.describe ItemCardapio, type: :model do
  let(:cardapio) { create(:cardapio) }
  let(:item) { create(:item_cardapio, cardapio: cardapio) }
  let(:promocao) { create(:promocao, item_cardapio: item, cardapio: item.cardapio) }

  it "belongs to a cardapio" do
    expect(item.cardapio).to eq(cardapio)
  end

  it "can have multiple promocoes" do
    expect(item.promocoes).to include(promocao)
  end
end
