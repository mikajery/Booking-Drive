require 'test_helper'

class Users::DriveWaysControllerTest < ActionController::TestCase
  setup do
    @users_drive_way = users_drive_ways(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_drive_ways)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_drive_way" do
    assert_difference('Users::DriveWay.count') do
      post :create, users_drive_way: { description: @users_drive_way.description, name: @users_drive_way.name, price: @users_drive_way.price }
    end

    assert_redirected_to users_drive_way_path(assigns(:users_drive_way))
  end

  test "should show users_drive_way" do
    get :show, id: @users_drive_way
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @users_drive_way
    assert_response :success
  end

  test "should update users_drive_way" do
    patch :update, id: @users_drive_way, users_drive_way: { description: @users_drive_way.description, name: @users_drive_way.name, price: @users_drive_way.price }
    assert_redirected_to users_drive_way_path(assigns(:users_drive_way))
  end

  test "should destroy users_drive_way" do
    assert_difference('Users::DriveWay.count', -1) do
      delete :destroy, id: @users_drive_way
    end

    assert_redirected_to users_drive_ways_path
  end
end
