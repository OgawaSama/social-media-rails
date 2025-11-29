require 'rails_helper'

RSpec.describe ItemConsumed, type: :model do
  before(:each) do
    @user = build(:user)
    @item = build(:item_consumed, user: @user)
  end

  it "belongs to a user" do
    expect(@item.user).to eq(@user)
  end

  it "checks for valid quantity" do
    expect(@item.quantity).not_to be < 0
  end

  it "checks for valid date" do
    expect(@item.date).not_to be_nil
  end

  describe ".summary" do
    it "returns items grouped and summed" do
      user = create(:user)
      create(:item_consumed, user:, name: "Beer", brand: "Itaipava", item_type: "Bebida", quantity: 1)
      create(:item_consumed, user:, name: "Beer", brand: "Itaipava", item_type: "Bebida", quantity: 4)

      summary = ItemConsumed
                  .select("name, brand, item_type, SUM(quantity) AS total_quantity")
                  .group(:name, :brand, :item_type)

      beer = summary.first

      expect(beer.total_quantity.to_i).to eq(5)
    end
  end
end
