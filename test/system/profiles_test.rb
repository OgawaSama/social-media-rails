require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @profile = profiles(:one)
    @profile.user = @user
    @profile.save
  end
# Profile faz coisas do User [Bookmark] Resolver
#  test "visiting the index" do
#    visit profiles_url
#    assert_selector "h1", text: "Profiles"
#  end
#
#  test "should create profile" do
#    visit profiles_url
#    click_on "New profile"
#
#    fill_in "User", with: @profile.user_id
#    click_on "Create Profile"
#
#    assert_text "Profile was successfully created"
#    click_on "Back"
#  end

#  test "should update Profile" do
#    visit profile_url(@profile)
#    click_on "Edit profile", match: :first
#
#    fill_in "User", with: @profile.user_id
#    click_on "Update Profile"
#
#    assert_text "Profile was successfully updated"
#    click_on "Back to profile"
#  end
# lugar errado
#  test "should destroy Profile" do
#    visit profile_url(@profile)
#    click_on "Destroy this profile", match: :first
#    assert_text "Profile was successfully destroyed"
#  end
end
