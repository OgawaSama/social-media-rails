require "test_helper"

module Posts
  class ReactionsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers if defined?(Devise)

    setup do
      @user = User.create!(email: "user@example.com", password: "password")
      @post = Post.create!(title: "Post de teste", content: "Conteúdo de teste", user: @user)
      @reaction = @user.reactions.create!(post: @post, name: "like")

      sign_in @user if respond_to?(:sign_in)
    end

    test "should create reaction" do
      assert_difference("@post.reactions.count", 1) do
        post post_reactions_path(@post), params: { name: "love" }
      end

      reaction = Reaction.last
      assert_equal @user, reaction.user
      assert_equal @post, reaction.post
      assert_equal "love", reaction.name
    end

    test "should count reactions" do
      get count_post_reactions_path(@post)
      assert_response :success

      controller = @controller
      assert_equal Reaction.count, controller.instance_variable_get(:@count)
    end

    test "should destroy reaction" do
      assert_difference("Reaction.count", -1) do
        delete post_reaction_path(@post, @reaction)
      end
    end
  end
end
