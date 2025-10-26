require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = build(:user)
    @user2 = build(:user)
  end

  # Shoulda matchers
  it { should validate_uniqueness_of(:username).case_insensitive }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it "checks for valid email" do
    # [Bookmark]
    # enable this when forcing emails to have ".something"
    # expect(@user1.email).to match(/^[\w\-\.\+]+@([\w-]+\.)+[\w-]{2,}$/)
    expect(@user1.email).to match(/^[\w\-\.\+]+@[\w\-\.\+]+$/)
  end

  it "checks for valid password" do
    # change along with password requirements
    expect(@user1.encrypted_password.length).to be >= 6

    @user1.encrypted_password = "tiny"
    expect(@user1.encrypted_password.length).to_not be >= 6
  end

  it "checks for profile presence" do
    user = build(:user)
    expect(user).to have_one(:profile)
  end
end
