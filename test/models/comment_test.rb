require "test_helper"

class CommentTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    @post = posts(:one)
    @comment = Comment.new(post: @post, user: @user)
  end

  test "should be valid with body" do
    assert @comment.valid?
  end

  test "should belong to a post" do
    @comment.post = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:post], "must exist"
  end

  test "should belong to a user" do
    @comment.user = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:user], "must exist"
  end
end
