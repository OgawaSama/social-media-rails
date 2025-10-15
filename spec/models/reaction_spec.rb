require 'rails_helper'

RSpec.describe Reaction, type: :model do
  before(:each) do
    @user = build(:user)
    @post = build(:post)
    @reaction = build(:reaction, user: @user, post: @post)
  end

  it "should belong to a user" do
    expect(@reaction.user).to eq(@user)

    @reaction.user = nil
    expect(@reaction).not_to be_valid
  end

  it "should belong to a post" do
    expect(@reaction.post).to eq(@post)

    @reaction.post = nil
    expect(@reaction).not_to be_valid
  end
end
