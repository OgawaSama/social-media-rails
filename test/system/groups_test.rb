require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  setup do
  @user = users(:one)
  sign_in @user

  @group = groups(:one)
  end

  test "should create group" do
    visit groups_user_path(@user)
    click_on "Novo grupo"

    fill_in "Name", with: @group.name
    click_on "Confirmar"

    assert_text "Group was successfully created"
    click_on "Back"
  end

  test "should update Group" do
    visit group_url(@group)
    click_on "Edit this group", match: :first

    fill_in "Name", with: @group.name
    click_on "Confirmar"

    assert_text "Group was successfully updated"
    click_on "Back"
  end

  test "should destroy Group" do
    visit group_url(@group)
    click_on "Destroy this group", match: :first

    assert_text "Group was successfully destroyed"
  end
end
