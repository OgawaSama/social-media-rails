require 'rails_helper'

RSpec.describe Business, type: :model do
  def add_rating(business, user, rating)
    if !Rate.where(business: business, user: user).present?
      Rate.create!(business: business, user: user, rating: rating)
    else
      Rate.update!(business: business, user: user, rating: rating)
    end
    business.rating = Rate.where(business: business).average(:rating)
    business.save!
  end

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

  context "checks for ratings" do
    # if anyone knows how to call the actual "add_ratings" function instead of improvising here, please change here

    before(:each) do
      @user2 = build(:user)
      @user3 = build(:user)
    end

    it "has default rating zero" do
      expect(@business.rating).to eq(0)
    end

    it "has rating 5" do
      add_rating(@business, @user2, 5)
      expect(@business.rating).to eq(5)
    end

    it "has mean rating 2.5" do
      add_rating(@business, @user2, 0)
      add_rating(@business, @user3, 5)
      expect(@business.rating).to eq(2.5)
    end

    it "updates same-user ratings" do
      add_rating(@business, @user2, 5)
      expect(@business.rating).to eq(5)
      add_rating(@business, @user2, 4)
      expect(@business.rating).to eq(4)
    end
  end
end
