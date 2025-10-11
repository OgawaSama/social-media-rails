require "test_helper"

class GroupTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    
    @post = posts(:one)
  end

  test "should be valid with body" do
    assert @post.valid?
  end

  test "should belong to a user" do
    @post.user = nil
    assert_not @post.valid?
    assert_includes @post.errors[:user], "must exist"
  end
end
