require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = build(:user)
    @post = build(:post)
    @comment = build(:comment, user: @user, post: @post)
  end

  it "checks for user ownership" do
    expect(@comment.user).to eq(@user)

    @comment.user = nil
    expect(@comment).not_to be_valid
  end

  it "checks for post ownership" do
    expect(@comment.post).to eq(@post)

    @comment.post = nil
    expect(@comment).not_to be_valid
  end

  it "checks for valid body" do
    # [Bookmark]
    # Add when having some restrictions
  end
end
