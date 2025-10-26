require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  # TODO: fix devise auth tests
  # test "update user" do
  #   patch edit_user_registration_url(@user), params: { user: { username: "newname",
  #                                                     first_name: "user", surnames: "name",
  #                                                     email: "user@name" } }
  #   assert_redirected_to feed_path
  # end

  # test "sign out" do
  #   sign_out @user
  #   assert_redirected_to root_path
  # end
end
