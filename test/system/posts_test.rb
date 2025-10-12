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

  # TODO: re-enable after rich-text is fixed
  # test "should create post" do
  #   visit posts_url
  #   click_on "New post"

  #   fill_in "Caption", with: @post.caption
  #   find('trix-editor#post_body.trix-content').set('awesomesauce')
  #   attach_file('Images', "test/fixtures/files/image/image.png")
  #   click_on "Save Post"

  #   assert_text "Post was successfully created"
  #   click_on "Back to feed"
  # end
  #
  # test "should update Post" do
  #   visit post_url(@post)
  #   click_on "Edit this post", match: :first

  #   fill_in "Caption", with: @post.caption
  #   find('trix-editor#post_body.trix-content').set('awesomesauce')
  #   attach_file('Images', "test/fixtures/files/image/image.png")
  #   click_on "Save Post"

  #   assert_text "Post was successfully updated"
  #   click_on "Back to feed"
  # end

  test "should destroy Post" do
    visit post_url(@post)
    click_on "Destroy this post", match: :first

    assert_text "Post was successfully destroyed"
  end

  # TOOD: needs rich-text...
  # test "should add comment" do
  #   assert true
  # end

  test "should add reaction" do
    visit feed_url
    click_on "♡"

    # genuinamente n sei oq dar assert aqui até o like atualizar sem ter que recarregar
    assert true
  end
end
