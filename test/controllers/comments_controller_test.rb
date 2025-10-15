require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user

    @post = posts(:one)
    @post.user = @user
    @post.save

    @comment = comments(:one)
    @comment.post = @post
    @comment.user = @user
    @comment.save
  end

  #   test "should add comment" do
  #     assert_difference("@post.comments.count") do
  #       post new_post_comment_url(@post), params: { post: { comment: { body: "so true bestie" } } }
  #     end
  #     assert_redirected_to feed_path
  #   end

  #   test "should delete comment" do
  #     assert_difference("@post.comments.count", -1) do
  #       delete post_comments_path(post_id: @post.id, id: @comment.id)
  #     end
  #     assert_redirected_to post_comment_url(@comment)
  #   end
end
