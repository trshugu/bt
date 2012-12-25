require '../test_helper'

class EeesControllerTest < ActionController::TestCase
  setup do
    @eee = eees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eee" do
    assert_difference('Eee.count') do
      post :create, eee: { name: @eee.name }
    end

    assert_redirected_to eee_path(assigns(:eee))
  end

  test "should show eee" do
    get :show, id: @eee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eee
    assert_response :success
  end

  test "should update eee" do
    put :update, id: @eee, eee: { name: @eee.name }
    assert_redirected_to eee_path(assigns(:eee))
  end

  test "should destroy eee" do
    assert_difference('Eee.count', -1) do
      delete :destroy, id: @eee
    end

    assert_redirected_to eees_path
  end
end
