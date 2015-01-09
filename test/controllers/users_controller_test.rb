require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get :index, application_id: @application.id
    assert_response 302 # :success
  end

end
