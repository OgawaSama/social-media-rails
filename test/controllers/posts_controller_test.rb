require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user

    @post = posts(:one)
    @post.user = @user
    @post.save
  end

  test "should get index" do
    get posts_url, as: :html
    assert_response :success
  end

  test "should get new" do
    get new_post_url, as: :html
    assert_response :success
  end
#[Bookmark] ver como fazer action text ser aceito no teste
 # test "should create post" do
    
    # assert_difference("Post.count") do
    #  post posts_url,
    #     params: { post: { content: "Meu novo post" } }, 
    #     as: :html
    # end
    # assert_redirected_to post_url(Post.last)
 # end

 # test "should update post" do
    # patch post_url(@post),
    #      params: { post: { content: "Atualizado" } },
    #      as: :html
    # @post.reload
    # assert_equal "Atualizado", @post.content.to_s
    # assert_redirected_to post_url(@post)
 # end

  test "should show post" do
    get post_url(@post), as: :html
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post), as: :html
    assert_response :success
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post), as: :html
    end
    # Se o seu controller redireciona para /feed em vez de /posts, altere aqui:
    assert_redirected_to feed_url
  end
end
