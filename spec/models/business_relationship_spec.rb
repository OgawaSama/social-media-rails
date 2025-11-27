require 'rails_helper'

RSpec.describe BusinessRelationship, type: :model do
  let(:user) { create(:user) }
  let(:business) { create(:business) }

  describe 'validations' do
    it 'validates presence of follower_id' do
      relationship = BusinessRelationship.new(follower_id: nil, follower_type: 'User', followed: business)
      expect(relationship).not_to be_valid
    end

    it 'validates uniqueness of follower-followed combination' do
      BusinessRelationship.create!(follower: user, followed: business)
      duplicate = BusinessRelationship.new(follower: user, followed: business)
      expect(duplicate).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to follower' do
      relationship = BusinessRelationship.create!(follower: user, followed: business)
      expect(relationship.follower).to eq(user)
    end

    it 'belongs to followed' do
      relationship = BusinessRelationship.create!(follower: user, followed: business)
      expect(relationship.followed).to eq(business)
    end
  end

  describe 'polymorphic associations' do
    let(:business1) { create(:business) }
    let(:business2) { create(:business, business_type: 'restaurant') }

    it 'allows business to follow business' do
      relationship = BusinessRelationship.create!(follower: business1, followed: business2)
      expect(relationship.follower).to eq(business1)
      expect(relationship.followed).to eq(business2)
    end

    it 'allows user to follow business' do
      relationship = BusinessRelationship.create!(follower: user, followed: business1)
      expect(relationship.follower).to eq(user)
      expect(relationship.followed).to eq(business1)
    end
  end
end
