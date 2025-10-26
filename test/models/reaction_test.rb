require "test_helper"

class ReactionTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    @post = posts(:one)
    @reaction = Reaction.new(post: @post, user: @user, name: "heart")
  end

  test "should be invalid without user" do
    @reaction.user = nil
    assert_not @reaction.valid?
    assert_includes @reaction.errors[:user], "must exist"
  end

  test "should be invalid without post" do
    @reaction.post = nil
    assert_not @reaction.valid?
    assert_includes @reaction.errors[:post], "must exist"
  end
end
