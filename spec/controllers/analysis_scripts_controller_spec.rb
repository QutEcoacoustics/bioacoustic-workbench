require 'spec_helper'

describe AnalysisScriptsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisScript
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:analysis_script)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisScript, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :description => nil,
          :name => nil,
          :display_name => nil,
          :extra_data => nil,
          :settings => nil,
          :version => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, AnalysisScript
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AnalysisScript.count
        test = convert_model(:create, :analysis_script, build(:analysis_script))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, AnalysisScript
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AnalysisScript.count
        test = convert_model(:create, :analysis_script, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, AnalysisScript, {:name=>["can't be blank", "is too short (minimum is 2 characters)", "is invalid"], :display_name=>["can't be blank", "is too short (minimum is 2 characters)"], :version=>["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:analysis_script)
        @changed.display_name = 'a new name for me'
        test = convert_model(:update, :analysis_script, @changed)
        @response_body = json_empty_body(test)
      end

      it_should_behave_like :a_valid_update_api_call, AnalysisScript, :display_name
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:analysis_script)
        @old_value = @initial.display_name
        @initial.display_name = ''
        test = convert_model(:update, :analysis_script, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, AnalysisScript, :display_name, {:name=>["can't be blank", "is too short (minimum is 2 characters)", "is invalid"], :display_name=>["can't be blank", "is too short (minimum is 2 characters)"]}
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