require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  setup do
    @search = searches(:one)
    authenticate_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search" do
    assert_difference('Search.count') do
      post :create, params: {
        search: { name: @search.name, color: @search.color, user_id: 1 }
      }
    end

    assert_redirected_to feed_path
  end

  test "should show search" do
    get :show, params: { id: @search }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @search }
    assert_response :success
  end

  test "should update search" do
    patch :update, params: { id: @search.id, search: { name: "New name"} }
    assert_redirected_to feed_path
    assert_equal "New name", @search.reload.name
  end

  test "should destroy search" do
    assert_difference('Search.count', -1) do
      delete :destroy, params: { id: @search }
    end

    assert_redirected_to feed_path
  end
end
