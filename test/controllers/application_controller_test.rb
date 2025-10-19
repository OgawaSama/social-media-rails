require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "ApplicationController define allow_browser com versions: :modern" do
    assert_respond_to ApplicationController, :allow_browser

    ApplicationController.stub :allow_browser, ->(options) {
      assert_equal({ versions: :modern }, options)
    } do
      load Rails.root.join("app/controllers/concerns/application_controllers.rb")
    end
  end
end
