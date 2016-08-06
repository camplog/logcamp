require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  def setup
    @application = applications(:one)
    authenticate_user
  end

  def teardown
    @application = nil
  end

  test "should get index" do
    get :index
    must_respond_with :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post :create, params: { application: { name: 'app13', owner_id: 1 } }
    end

    assert_redirected_to applications_path
  end

  test "should show application" do
    @application.members << users(:one)
    get :show, params: { id: @application.id }
    assert_response :success
  end

  test "should not show application if not a member" do
    @application.members.delete_all
    get :show, params: { id: @application.id }
    assert_redirected_to feed_path
  end

  test "should get edit" do
    get :edit, params: { id: @application.id }
    assert_response :success
  end

  test "should update application" do
    patch :update, params: { id: @application.id, application: { name: 'New name'} }
    assert_redirected_to application_path(assigns(:application))
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, params: { id: @application.id }
    end

    assert_redirected_to applications_path
  end

end
