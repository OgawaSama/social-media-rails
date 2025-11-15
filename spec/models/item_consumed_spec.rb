require 'rails_helper'

RSpec.describe ItemConsumed, type: :model do
  before(:each) do
    @user = build(:user)
    @item = build(:item_consumed, user: @user)
  end

  it "belongs to a user" do
    expect(item.user).to eq(@user)
  end

  it "checks for valid quantity" do
    expect(item.user).not_to be < 0
  end

  it "checks for valid date" do
    expect(item.date).not_to be_nil
  end
end
