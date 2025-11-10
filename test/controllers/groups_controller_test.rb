require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)       # Usuário de fixture
    sign_in @user             # Loga o usuário
    @group = groups(:one)
    GroupParticipation.create!(group: @group, user: @user)
  end

  test "should get new" do
    get new_group_url
    assert_response :success
  end

  test "should create group" do
    assert_difference("Group.count") do
      post groups_url, params: { group: { name: @group.name } }
    end

    assert_redirected_to group_url(Group.last)
  end

  test "should show group" do
    get group_url(@group)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_response :success
  end

  test "should update group" do
    patch group_url(@group), params: { group: { name: @group.name, bio: "abababa" } }
    assert_redirected_to group_url(@group)
  end

  test "should destroy group" do
    assert_difference("Group.count", -1) do
      delete group_url(@group)
    end

    assert_redirected_to feed_url
  end

    test "should create group with header" do
    assert_difference("Group.count", 1) do
      post groups_url, params: {
        group: {
          name: "Grupo com Header",
          header: fixture_file_upload("test/fixtures/files/teste.png", "image/jpeg")
        }
      }
    end
    assert_redirected_to group_url(Group.last)
  end

  test "should not create group without name" do
    assert_no_difference("Group.count") do
      post groups_url, params: { group: { name: "" } }
    end
    assert_response :unprocessable_entity
  end
end
