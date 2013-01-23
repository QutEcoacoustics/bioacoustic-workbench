require 'spec_helper'

describe AnalysisItemsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisItem
  end

  describe "GET #show" do
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisItem, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :worker_info => nil,
          :worker_started_utc => nil,
          :worker_run_details => nil,
          :status => 'ready',
          :offset_start_seconds => nil,
          :offset_end_seconds => nil,
          :audio_recording_id => nil,
          :updated_at => nil,
          :created_at => nil
      }
    end

    it_should_behave_like :a_new_api_call, AnalysisItem
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AnalysisItem.count
        @response_body = json({ post: :create, analysis_item: build(:analysis_item).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, AnalysisItem
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AnalysisItem.count
        @response_body = json({ post: :create, analysis_item: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, AnalysisItem, {:offset_start_seconds=>["can't be blank", "is not a number"], :offset_end_seconds=>["can't be blank", "is not a number"], :audio_recording_id=>["can't be blank"], :status=>["is not included in the list"]}
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