require 'test_helper'

class Panel::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_welcome_index_url
    assert_response :success
  end

end
