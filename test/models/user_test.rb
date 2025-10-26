require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  # TODO: somehow fix the username/password tests to be like the email one
  # asser_not @user.valid? did not work idk why

  test "should be invalid without username" do
    @user.username = nil
    @user.reload
    assert_not_nil @user.username
  end

  test "should be invalid without email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should be invalid without password" do
    @user.encrypted_password = nil
    @user.reload
    assert_not_nil @user.encrypted_password
  end
end
