require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get docs" do
    get :docs
    assert_response :success
  end

  test "should get homepage" do
    get :home
    assert_response :success
  end
end
