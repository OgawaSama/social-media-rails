require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user

    @post = posts(:one)
    @post.user = @user
    @post.save
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    visit posts_url
    click_on "New post"

    fill_in "Caption", with: @post.caption
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "should update Post" do
    visit post_url(@post)
    click_on "Edit this post", match: :first

    fill_in "Caption", with: @post.caption
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "should destroy Post" do
    visit post_url(@post)
    click_on "Destroy this post", match: :first

    assert_text "Post was successfully destroyed"
  end
end
