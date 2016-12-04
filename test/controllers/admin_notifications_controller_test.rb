require 'test_helper'

class AdminNotificationsControllerTest < ActionController::TestCase
  setup do
    @admin_notification = admin_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_notification" do
    assert_difference('AdminNotification.count') do
      post :create, admin_notification: { email: @admin_notification.email, name: @admin_notification.name, status: @admin_notification.status, time_zone: @admin_notification.time_zone }
    end

    assert_redirected_to admin_notification_path(assigns(:admin_notification))
  end

  test "should show admin_notification" do
    get :show, id: @admin_notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_notification
    assert_response :success
  end

  test "should update admin_notification" do
    patch :update, id: @admin_notification, admin_notification: { email: @admin_notification.email, name: @admin_notification.name, status: @admin_notification.status, time_zone: @admin_notification.time_zone }
    assert_redirected_to admin_notification_path(assigns(:admin_notification))
  end

  test "should destroy admin_notification" do
    assert_difference('AdminNotification.count', -1) do
      delete :destroy, id: @admin_notification
    end

    assert_redirected_to admin_notifications_path
  end
end
