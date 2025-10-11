require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @profile = profiles(:one)
  end
  

  test "should show profile" do
    get profile_url(@profile), as: :html
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile), as: :html
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { bio: "bio" } }
    @profile.reload
    # sim o action text foi formatado assim pra ser aceito O.o
    assert_equal "<div class=\"trix-content\">
  bio
</div>
", @profile.bio.to_s
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference("Profile.count", -1) do
      delete profile_url(@profile), as: :html
    end
    assert_redirected_to profiles_url
  end
end
