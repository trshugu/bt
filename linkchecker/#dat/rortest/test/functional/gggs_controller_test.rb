require 'test_helper'

class GggsControllerTest < ActionController::TestCase
  setup do
    @ggg = gggs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gggs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ggg" do
    assert_difference('Ggg.count') do
      post :create, ggg: { nana: @ggg.nana }
    end

    assert_redirected_to ggg_path(assigns(:ggg))
  end

  test "should show ggg" do
    get :show, id: @ggg
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ggg
    assert_response :success
  end

  test "should update ggg" do
    put :update, id: @ggg, ggg: { nana: @ggg.nana }
    assert_redirected_to ggg_path(assigns(:ggg))
  end

  test "should destroy ggg" do
    assert_difference('Ggg.count', -1) do
      delete :destroy, id: @ggg
    end

    assert_redirected_to gggs_path
  end
end
