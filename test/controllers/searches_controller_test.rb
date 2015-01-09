require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  setup do
    @search = searches(:one)
    current_user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response 302 # :success
    assert_not_nil assigns(:searches)
  end

  test "should get new" do
    get :new
    assert_response 302 # :success
  end

  test "should create search" do
    assert_difference('Search.count') do
      post :create, search: { name: @search.name, color: @search.color, user_id: 1 }
    end

    assert_redirected_to feed_path
  end

  test "should show search" do
    get :show, id: @search
    assert_response 302 # :success
  end

  test "should get edit" do
    get :edit, id: @search
    assert_response 302 # :success
  end

  test "should update search" do
    patch :update, id: @search.id, search: {  }
    assert_redirected_to feed_path
  end

  test "should destroy search" do
    assert_difference('Search.count', -1) do
      delete :destroy, id: @search
    end

    assert_redirected_to feed_path
  end
end
