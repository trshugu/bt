require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  setup do
    @bookmark = bookmarks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark" do
    assert_difference('Bookmark.count') do
      post :create, bookmark: { httpcode: @bookmark.httpcode, name: @bookmark.name, status: @bookmark.status, tag: @bookmark.tag, uri: @bookmark.uri }
    end

    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should show bookmark" do
    get :show, id: @bookmark
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmark
    assert_response :success
  end

  test "should update bookmark" do
    put :update, id: @bookmark, bookmark: { httpcode: @bookmark.httpcode, name: @bookmark.name, status: @bookmark.status, tag: @bookmark.tag, uri: @bookmark.uri }
    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete :destroy, id: @bookmark
    end

    assert_redirected_to bookmarks_path
  end
end
