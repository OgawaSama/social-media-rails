require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get userindex" do
    get pages_userindex_url
    assert_response :success
  end

  test "should get barindex" do
    get pages_barindex_url
    assert_response :success
  end
end
