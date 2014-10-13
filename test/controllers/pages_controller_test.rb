require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get docs" do
    get :docs
    assert_response :success
  end

end
