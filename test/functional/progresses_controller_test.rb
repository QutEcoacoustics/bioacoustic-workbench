require 'test_helper'

class ProgressesControllerTest < ActionController::TestCase
  setup do
    @progress = progresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create progress" do
    assert_difference('Progress.count') do
      post :create, progress: { activity: @progress.activity, bit_map: @progress.bit_map }
    end

    assert_redirected_to progress_path(assigns(:progress))
  end

  test "should show progress" do
    get :show, id: @progress
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @progress
    assert_response :success
  end

  test "should update progress" do
    put :update, id: @progress, progress: { activity: @progress.activity, bit_map: @progress.bit_map }
    assert_redirected_to progress_path(assigns(:progress))
  end

  test "should destroy progress" do
    assert_difference('Progress.count', -1) do
      delete :destroy, id: @progress
    end

    assert_redirected_to progresses_path
  end
end
