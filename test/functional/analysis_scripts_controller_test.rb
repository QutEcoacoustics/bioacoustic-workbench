require 'test_helper'

class AnalysisScriptsControllerTest < ActionController::TestCase
  setup do
    @analysis_script = analysis_scripts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysis_scripts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analysis_script" do
    assert_difference('AnalysisScript.count') do
      post :create, analysis_script: { description: @analysis_script.description, display_name: @analysis_script.display_name, extra_data: @analysis_script.extra_data, name: @analysis_script.name, settings: @analysis_script.settings, version: @analysis_script.version }
    end

    assert_redirected_to analysis_script_path(assigns(:analysis_script))
  end

  test "should show analysis_script" do
    get :show, id: @analysis_script
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analysis_script
    assert_response :success
  end

  test "should update analysis_script" do
    put :update, id: @analysis_script, analysis_script: { description: @analysis_script.description, display_name: @analysis_script.display_name, extra_data: @analysis_script.extra_data, name: @analysis_script.name, settings: @analysis_script.settings, version: @analysis_script.version }
    assert_redirected_to analysis_script_path(assigns(:analysis_script))
  end

  test "should destroy analysis_script" do
    assert_difference('AnalysisScript.count', -1) do
      delete :destroy, id: @analysis_script
    end

    assert_redirected_to analysis_scripts_path
  end
end
