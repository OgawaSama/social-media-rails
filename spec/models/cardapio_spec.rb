require 'rails_helper'

RSpec.describe Cardapio, type: :model do
  let(:business_address) { create(:business_address) }
  let(:cardapio) { create(:cardapio, business_address: business_address) }

  before do
    cardapio.business_addresses << [ address1, address2 ]
  end

  describe "business_addresses associations" do
    it "can belong to multiple business addresses" do
      expect(cardapio.business_addresses).to include(address1, address2)
    end
  end

  describe "promocoes associations" do
    let(:promocao) { create(:promocao, cardapio: cardapio) }

    it "can have many promocoes" do
      expect(cardapio.promocoes).to include(promocao)
    end
  end
end
