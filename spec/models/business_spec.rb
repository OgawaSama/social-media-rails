require 'rails_helper'

RSpec.describe Business, type: :model do
  def add_rating(business, user, rating)
    if !Rate.where(business: business, user: user).present?
      Rate.create!(business: business, user: user, rating: rating)
    else
      rate = Rate.find_by(business: business, user: user)
      rate.update!(rating: rating)
    end
    business.rating = Rate.where(business: business).average(:rating)
    business.save!
  end

  before(:each) do
    @user = create(:user)
    @business = create(:business, user: @user)
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
    before(:each) do
      @user2 = create(:user)
      @user3 = create(:user)
    end

    it "has default rating zero" do
      expect(@business.rating).to eq(0.0)
    end

    it "has rating 5" do
      add_rating(@business, @user2, 5)
      expect(@business.rating).to eq(5.0)
    end

    it "has mean rating 2.5" do
      add_rating(@business, @user2, 0)
      add_rating(@business, @user3, 5)
      expect(@business.rating).to eq(2.5)
    end

    it "updates same-user ratings" do
      add_rating(@business, @user2, 5)
      expect(@business.rating).to eq(5.0)
      add_rating(@business, @user2, 4)
      expect(@business.rating).to eq(4.0)
    end
  end

  # NOVOS TESTES PARA AS NOVAS FUNCIONALIDADES
  describe 'new business type functionality' do
    it 'validates business_type presence' do
      @business.business_type = nil
      expect(@business).not_to be_valid
    end

    it 'validates business_type inclusion' do
      @business.business_type = 'invalid_type'
      expect(@business).not_to be_valid
    end

    it 'accepts valid business types' do
      valid_types = %w[bar restaurant cafe store other]
      valid_types.each do |type|
        @business.business_type = type
        expect(@business).to be_valid
      end
    end

    describe 'scopes' do
      let!(:bar) { create(:business, company_name: 'Bar do Zé', business_type: 'bar') }
      let!(:restaurant) { create(:business, company_name: 'Restaurante Sabor', business_type: 'restaurant') }

      it '.bars returns only bars' do
        expect(Business.bars).to include(bar)
        expect(Business.bars).not_to include(restaurant)
      end

      it '.search returns businesses matching query' do
        # Teste com nome da empresa
        expect(Business.search('Zé')).to include(bar)
        expect(Business.search('Sabor')).to include(restaurant)

        # Teste com tipo de negócio
        expect(Business.search('bar')).to include(bar)
        expect(Business.search('restaurant')).to include(restaurant)
      end
    end

    describe '#bar?' do
      it 'returns true for bars' do
        bar = create(:business, business_type: 'bar')
        expect(bar.bar?).to be true
      end

      it 'returns false for non-bars' do
        restaurant = create(:business, business_type: 'restaurant')
        expect(restaurant.bar?).to be false
      end
    end

    describe '#humanized_business_type' do
      it 'returns humanized business type for bar' do
        @business.business_type = 'bar'
        expect(@business.humanized_business_type).to eq('Bar')
      end

      it 'returns humanized business type for restaurant' do
        @business.business_type = 'restaurant'
        expect(@business.humanized_business_type).to eq('Restaurante')
      end
    end
  end

  describe 'business relationships' do
    let(:user) { create(:user) }
    let(:other_business) { create(:business, business_type: 'restaurant') }

    it 'has followers' do
      expect(@business).to respond_to(:followers)
    end

    it 'has following_businesses' do
      expect(@business).to respond_to(:following_businesses)
    end

    describe '#followed_by?' do
      it 'returns true if user follows the business' do
        user.follow_business(@business)
        expect(@business.followed_by?(user)).to be true
      end

      it 'returns false if user does not follow the business' do
        expect(@business.followed_by?(user)).to be false
      end
    end
  end
end
