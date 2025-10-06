require "test_helper"

module Posts
  class CommentsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers if defined?(Devise)

    setup do
      @user = User.create!(email: "user@example.com", password: "password")
      @post = Post.create!(title: "Post de teste", content: "Conteúdo de teste", user: @user)
      @comment = @post.comments.create!(body: "Comentário existente", user: @user)

      sign_in @user if respond_to?(:sign_in)
    end

    test "should get new" do
      get new_post_comment_path(@post)
      assert_response :success
    end

    test "should create comment" do
      assert_difference("@post.comments.count", 1) do
        post post_comments_path(@post), params: { comment: { body: "Novo comentário" } }
      end

      assert_redirected_to feed_path
      assert_equal @user, Comment.last.user
      assert_equal @post, Comment.last.post
    end

    test "should not create invalid comment" do
      assert_no_difference("@post.comments.count") do
        post post_comments_path(@post), params: { comment: { body: "" } }
      end

      assert_response :success
      assert_template :new
    end

    test "should count comments" do
      get count_post_comments_path(@post)
      assert_response :success

      controller = @controller
      assert_equal Comment.count, controller.instance_variable_get(:@count)
    end

    test "should destroy comment" do
      assert_difference("Comment.count", -1) do
        delete post_comment_path(@post, @comment)
      end
    end
  end
end
