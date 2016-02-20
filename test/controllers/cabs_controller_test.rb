require 'test_helper'

class CabsControllerTest < ActionController::TestCase
  setup do
    @cab = cabs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cabs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cab" do
    assert_difference('Cab.count') do
      post :create, cab: { location_x: @cab.location_x, location_y: @cab.location_y, status: @cab.status, type: @cab.type }
    end

    assert_redirected_to cab_path(assigns(:cab))
  end

  test "should show cab" do
    get :show, id: @cab
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cab
    assert_response :success
  end

  test "should update cab" do
    patch :update, id: @cab, cab: { location_x: @cab.location_x, location_y: @cab.location_y, status: @cab.status, type: @cab.type }
    assert_redirected_to cab_path(assigns(:cab))
  end

  test "should destroy cab" do
    assert_difference('Cab.count', -1) do
      delete :destroy, id: @cab
    end

    assert_redirected_to cabs_path
  end
end
