require 'spec_helper'

describe AnalysisItemsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :a_standard_api_call, AnalysisItem
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

class AnalysisItemsControllerTest < ActionController::TestCase
  setup do
    @analysis_item = AnalysisItem.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysis_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analysis_item" do
    assert_difference('AnalysisItem.count') do
      post :create, { auth_token: get_admin.authentication_token, analysis_item: { audio_recording_id: @analysis_item.audio_recording_id, offset_end_seconds: @analysis_item.offset_end_seconds, offset_start_seconds: @analysis_item.offset_start_seconds, status: @analysis_item.status, worker_info: @analysis_item.worker_info, worker_run_details: @analysis_item.worker_run_details, worker_started_utc: @analysis_item.worker_started_utc } }
    end

    assert_redirected_to analysis_item_path(assigns(:analysis_item))
  end

  test "should show analysis_item" do
    get :show, id: @analysis_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analysis_item
    assert_response :success
  end

  test "should update analysis_item" do
    put :update, id: @analysis_item, analysis_item: { offset_end_seconds: @analysis_item.offset_end_seconds, offset_start_seconds: @analysis_item.offset_start_seconds, status: @analysis_item.status, worker_info: @analysis_item.worker_info, worker_run_details: @analysis_item.worker_run_details, worker_started_utc: @analysis_item.worker_started_utc }
    assert_redirected_to analysis_item_path(assigns(:analysis_item))
  end

  test "should destroy analysis_item" do
    assert_difference('AnalysisItem.count', -1) do
      delete :destroy, id: @analysis_item
    end

    assert_redirected_to analysis_items_path
  end
end
=end