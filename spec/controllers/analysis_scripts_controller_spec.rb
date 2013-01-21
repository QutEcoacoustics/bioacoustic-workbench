require 'spec_helper'

describe AnalysisScriptsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisScript
  end

  describe "GET #show" do
    it "assigns the requested item to the local variable"
    it "renders the item in json with the expected properties"
  end

  describe "GET #new" do
    it "assigns a new item to the local variable"
    it "renders the item in json with the expected properties"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new item in the database"
      it "renders the new item in json with the expect properties, with status 201, with location header"
    end

    context "with invalid attributes" do
      it "does not save the new item in the database"
      it "renders the error in json with expected properties, with status 422"
    end
  end

  describe "PUT #update" do
    it 'exists in the database'

    context "with valid attributes" do
      it "updates the existing item in the database"
      it "returns with empty body and with status 200"
    end

    context "with invalid attributes" do
      it "does not update the existing item in the database"
      it "renders the error in json with expected properties, with status 422"
    end
  end

  describe "DELETE #destory" do
    it "finds the correct item fromthe database and assigns it to the local variable"
    it 'destories the correct item, and the database is updated'
    it "returns with empty body and with status 200"
  end
end

=begin
require 'test_helper'

class AnalysisScriptsControllerTest < ActionController::TestCase
  setup do
    @analysis_script = AnalysisScript.first!
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
      #current_user
      post :create, { analysis_script: { description: @analysis_script.description, display_name: @analysis_script.display_name, extra_data: @analysis_script.extra_data, name: @analysis_script.name, settings: @analysis_script.settings, version: @analysis_script.version }, auth_token: '' }
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
=end