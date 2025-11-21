require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
  end

  # Shoulda matchers
  it { should validate_uniqueness_of(:username).case_insensitive }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it "checks for valid email" do
    expect(@user1.email).to match(/^[\w\-\.\+]+@[\w\-\.\+]+$/)
  end

  it "checks for valid password" do
    expect(@user1.encrypted_password.length).to be >= 6
  end

  it "checks for profile presence" do
    user = create(:user)
    expect(user).to have_one(:profile)
  end

  # NOVOS TESTES PARA AS NOVAS FUNCIONALIDADES
  describe 'business associations' do
    it { should have_one(:business).dependent(:destroy) }
  end

  describe 'business following functionality' do
    let(:business) { create(:business) }

    it 'has business relationship associations' do
      expect(@user1).to have_many(:active_business_relationships)
      expect(@user1).to have_many(:passive_business_relationships)
      expect(@user1).to have_many(:following_businesses)
      expect(@user1).to have_many(:business_followers)
    end

    describe '#follow_business' do
      it 'allows user to follow a business' do
        expect {
          @user1.follow_business(business)
        }.to change { @user1.following_businesses.count }.by(1)
      end

      it 'does not allow duplicate follows' do
        @user1.follow_business(business)
        expect {
          @user1.follow_business(business)
        }.not_to change { @user1.following_businesses.count }
      end
    end

    describe '#unfollow_business' do
      it 'allows user to unfollow a business' do
        @user1.follow_business(business)
        expect {
          @user1.unfollow_business(business)
        }.to change { @user1.following_businesses.count }.by(-1)
      end
    end

    describe '#following_business?' do
      it 'returns true when user follows business' do
        @user1.follow_business(business)
        expect(@user1.following_business?(business)).to be true
      end

      it 'returns false when user does not follow business' do
        expect(@user1.following_business?(business)).to be false
      end
    end

    describe '#feed includes business posts' do
      let(:business_user) { create(:user, :business_user) }
      let(:business) { business_user.business }
      let!(:business_post) { create(:post, user: business_user) }

      it 'includes posts from followed businesses' do
        @user1.follow_business(business)
        expect(@user1.feed).to include(business_post)
      end

      it 'does not include posts from unfollowed businesses' do
        expect(@user1.feed).not_to include(business_post)
      end
    end
  end
end
