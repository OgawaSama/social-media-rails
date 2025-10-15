require 'rails_helper'

RSpec.describe BusinessAddress, type: :model do
  before(:each) do
    @user = build(:user)
    @business = build(:business, user: @user)
    @business_address = build(:business_address, business: @business)
  end

  it "checks business ownership" do
    expect(@business_address.business).to eq(@business)

    @business_address.business = nil
    expect(@business_address).not_to be_valid
  end

  it "validates street" do
    expect(@business_address.street).not_to be_nil

    @business_address.street = nil
    expect(@business_address).not_to be_valid
  end

  it "validates city" do
    expect(@business_address.city).not_to be_nil

    @business_address.city = nil
    expect(@business_address).not_to be_valid
  end

  it "validates state" do
    expect(@business_address.state).not_to be_nil

    @business_address.state = nil
    expect(@business_address).not_to be_valid
  end

  it "validates zip" do
    expect(@business_address.zip).not_to be_nil

    @business_address.zip = nil
    expect(@business_address).not_to be_valid
  end
end
