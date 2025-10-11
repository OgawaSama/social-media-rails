require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)       # Usuário de fixture
    sign_in @user             # Loga o usuário
    @profile = profiles(:one) # Profile de fixture
  end

  test "should get show" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { bio: "bio" } }
    assert_redirected_to profile_url(@profile)
  end
end
