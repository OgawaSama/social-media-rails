require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before(:each) do
    @follower = build(:user)
    @followed = build(:user)
    @relationship = build(:relationship, follower: @follower, followed: @followed)
  end

  it "should have a follower" do
    expect(@relationship.follower).to eq(@follower)

    @relationship.follower = nil
    expect(@relationship).not_to be_valid
  end

  it "should have a followed" do
    expect(@relationship.followed).to eq(@followed)

    @relationship.followed = nil
    expect(@relationship).not_to be_valid
  end

  describe "validations" do
    subject { Relationship.create(follower: @follower, followed: @followed) }
    it { should validate_uniqueness_of(:follower_id).scoped_to(:followed_id).case_insensitive }
  end

end
