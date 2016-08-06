require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
    authenticate_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create event" do
  #   assert_difference('Event.count') do
  #     post :create, event: { application_id: @event.application_id, message: @event.message, status: @event.status }
  #   end

  #   assert_redirected_to event_path(assigns(:event))
  # end

  # test "should destroy event" do
  #   assert_difference('Event.count', -1) do
  #     delete :destroy, id: @event
  #   end

  #   assert_redirected_to events_path
  # end
end
