require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @profile = profiles(:one)
    @profile.user = @user
    @profile.save
  end
#Nao era pra existir
#  test "should get index" do
#    get profiles_url, as: :html
#    assert_response :success
#  end

#  test "should get new" do
#    get new_profile_url, as: :html
#    assert_response :success
#  end
#[Bookmark] ver como fazer action text ser aceito no teste
#  test "should create profile" do
#    assert_difference("Profile.count") do
#      post profiles_url, params: { profile: { bio: "Meu bio", header: "Header" } }, as: :html
#    end
#    assert_redirected_to profile_url(Profile.last)
#    # Verificar conteúdo ActionText
#    assert_equal "Meu bio", Profile.last.bio.to_s
#  end

  test "should show profile" do
    get profile_url(@profile), as: :html
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile), as: :html
    assert_response :success
  end
#[Bookmark] ver como fazer action text ser aceito no teste
#  test "should update profile" do
#    patch profile_url(@profile), params: { profile: { bio: "Atualizado" } }, as: :html
#    @profile.reload
#    assert_equal "Atualizado", @profile.bio.to_s
#    assert_redirected_to profile_url(@profile)
#  end

  test "should destroy profile" do
    assert_difference("Profile.count", -1) do
      delete profile_url(@profile), as: :html
    end
    assert_redirected_to profiles_url
  end
end
