require "test_helper"

class FeedControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get show" do
    get feed_url   # corresponde à rota: get "feed", to: "feed#show", as: :feed
    assert_response :success
  end

  test "should search users" do
    get search_users_url, params: { query: "andre" }  # se você tiver busca por query
    assert_response :success
  end
end
