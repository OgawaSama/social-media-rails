require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @profile = @user.profile

    @user2 = users(:two)
    @profile2 = @user2.profile
  end

  # TODO: esperar o rich_text...
  # test "should update Profile" do
  #   visit profile_url(@profile)
  #   click_on "Edit profile", match: :first

  #   find('trix-editor#profile_bio.trix-content').set('awesomesauce')
  #   attach_file('Avatar', "test/fixtures/files/image/image.png")
  #   attach_file('Header', "test/fixtures/files/image/image.png")
  #   click_on "Update Profile"

  #   assert_text "Profile was successfully updated"
  # end

  test "should follow someone" do
    visit profile_url(@profile2)
    click_on "Follow"

    assert_text "Unfollow"
  end

  # TODO: descobrir como seguir alguém
  # test "should unfollow someone" do
  #   post follow_user_path(@user2)
  #   visit profile_url(@profile2)
  #   click_on "Deixar de seguir"

  #   assert_text "Você deixou de seguir #{@user2.username}"
  # end

  # TODO: Não sei se deveria ficar aqui ou no controller
  # test "should view follower list" do
  #   visit profile_url(@profile)
  #   click_on "seguidores"

  #   assert_redirected_to followers_user_url(@profile)
  #   assert true
  # end

  # test "should view following list" do
  #   assert true
  # end

  # test "should see group list" do
  #   assert true
  # end
end
