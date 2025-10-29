require 'rails_helper'

RSpec.describe Business, type: :model do
  before(:each) do
    @user = build(:user)
    @business = build(:business, user: @user)
  end

  it "checks for user ownership" do
    expect(@business.user).to eq(@user)

    @business.user = nil
    expect(@business).not_to be_valid
  end

  context "checks for valid cnpj" do
    it "permits only numbers" do
      expect(@business).to be_valid
      @business.cnpj = "banana"
      expect(@business).not_to be_valid
    end

    it "checks for length to be equal to 14" do
      @business.cnpj = "123"
      expect(@business).not_to be_valid
      @business.cnpj = "123456712345678"
      expect(@business).not_to be_valid
    end
  end
end
