require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  setup :initialize_application

  def teardown
    @application = nil
  end

  test "should get index" do
    get :index
    # assert_template file: 'applications/index'
    # must_render_template 'applications/index'
    must_respond_with 302 # :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response 302
  end

  test "should create application" do
    application
    assert_difference('Application.count') do
      post :create, application: { name: 'app13', owner_id: 1 }
    end

    assert_redirected_to applications_path
  end

  test "should show application" do
    get :show, id: @application.id
    assert_response 302
  end

  test "should get edit" do
    get :edit, id: @application.id
    assert_response 302 # :success
  end

  test "should update application" do
    # patch :update, id: @application.id, application: { name: 'app3', owner_id: @application.owner_id }
    # assert_redirected_to application_path(assigns(:application))
    patch :update, id: @application.id, application: {}
    assert_redirected_to application_path(assigns(:application))
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, id: @application.id
    end

    assert_redirected_to applications_path
  end

  private

  def initialize_application
    @application = applications(:one)
    current_user = users(:one)
  end
end
