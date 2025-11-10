require 'rails_helper'

RSpec.describe Promocao, type: :model do
  let(:cardapio) { create(:cardapio) }
  let(:item) { create(:item_cardapio, cardapio: cardapio) }

  it "can belong to a cardapio" do
    promocao = build(:promocao, cardapio: cardapio)
    expect(promocao.cardapio).to eq(cardapio)
  end

  it "can belong to an item_cardapio" do
    promocao = build(:promocao, item_cardapio: item)
    expect(promocao.item_cardapio).to eq(item)
  end
end
