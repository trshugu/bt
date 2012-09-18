require 'test_helper'

class TmpsControllerTest < ActionController::TestCase
  setup do
    @tmp = tmps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tmps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tmp" do
    assert_difference('Tmp.count') do
      post :create, tmp: { test: @tmp.test }
    end

    assert_redirected_to tmp_path(assigns(:tmp))
  end

  test "should show tmp" do
    get :show, id: @tmp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tmp
    assert_response :success
  end

  test "should update tmp" do
    put :update, id: @tmp, tmp: { test: @tmp.test }
    assert_redirected_to tmp_path(assigns(:tmp))
  end

  test "should destroy tmp" do
    assert_difference('Tmp.count', -1) do
      delete :destroy, id: @tmp
    end

    assert_redirected_to tmps_path
  end
end
