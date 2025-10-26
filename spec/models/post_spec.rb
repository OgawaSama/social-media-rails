require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = build(:user)
    @post = build(:post, user: @user)
  end

  it "checks for user ownership" do
    expect(@post.user).to eq(@user)

    @post.user = nil
    expect(@post).not_to be_valid
  end

  it "checks for valid caption" do
    # [Bookmark]
    # Add when having some restrictions
  end

  it "checks for valid body" do
    # [Bookmark]
    # Add when having some restrictions
  end

  it "checks for valid image formats" do
    # wanted to do @post.images but got error
    #  'undefined method 'valid?' for an instance of ActiveStorage::Attached::Many'
    expect(@post).to be_valid

    @post.images.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'pdf.pdf')),
            filename: 'pdf.pdf',
            content_type: 'application/pdf'
        )
    expect(@post).not_to be_valid
  end
end
