require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @photo = photos(:photo_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo" do
    #puts "OUT! ---> " + Photo.count.to_s()
    assert_difference('Photo.count') do
      post :create, photo: { copyright: @photo.copyright, uri: @photo.uri }
    end

    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should show photo" do
    get :show, id: @photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photo
    assert_response :success
  end

  test "should update photo" do
    put :update, id: @photo, photo: { copyright: (@photo.copyright + "a change!"), uri: @photo.uri, description: (@photo.description + " more text") }
    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should destroy photo" do
    assert_difference('Photo.count', -1) do
      delete :destroy, id: @photo
    end

    assert_redirected_to photos_path
  end
end
