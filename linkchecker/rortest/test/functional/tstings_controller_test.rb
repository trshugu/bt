require '../test_helper'

class TstingsControllerTest < ActionController::TestCase
  setup do
    @tsting = tstings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tstings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tsting" do
    assert_difference('Tsting.count') do
      post :create, tsting: { aaa: @tsting.aaa, bbb: @tsting.bbb, ccc: @tsting.ccc }
    end

    assert_redirected_to tsting_path(assigns(:tsting))
  end

  test "should show tsting" do
    get :show, id: @tsting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tsting
    assert_response :success
  end

  test "should update tsting" do
    put :update, id: @tsting, tsting: { aaa: @tsting.aaa, bbb: @tsting.bbb, ccc: @tsting.ccc }
    assert_redirected_to tsting_path(assigns(:tsting))
  end

  test "should destroy tsting" do
    assert_difference('Tsting.count', -1) do
      delete :destroy, id: @tsting
    end

    assert_redirected_to tstings_path
  end
end
