require "test_helper"

module Posts
  class BaseControllerTest < ActionDispatch::IntegrationTest
    setup do
      @post = Post.create!(title: "Post de teste", content: "Conteúdo qualquer")
    end

    test "set_post define a variável @post corretamente" do
      controller = Posts::BaseController.new

      controller.params = ActionController::Parameters.new(post_id: @post.id)

      controller.send(:set_post)

      assert_equal @post, controller.instance_variable_get(:@post)
    end
  end
end
