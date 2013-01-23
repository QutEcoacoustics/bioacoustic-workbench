require 'spec_helper'

describe ProgressesController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Progress
  end

  describe "GET #show" do
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Progress, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :activity => nil,
          :audio_recording_id => nil,
          :end_offset_seconds => nil,
          :offset_list => nil,
          :saved_search_id => nil,
          :start_offset_seconds => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, Progress
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Progress.count
        @response_body = json({ post: :create, progress: build(:progress).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, Progress
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Progress.count
        @response_body = json({ post: :create, progress: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, Progress, {:offset_list=>["can't be blank"], :activity=>["can't be blank"], :saved_search_id=>["can't be blank"], :audio_recording_id=>["can't be blank"], :start_offset_seconds=>["can't be blank", "is not a number"], :end_offset_seconds=>["can't be blank", "is not a number"], :creator_id=>["can't be blank"]}
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

class ProgressesControllerTest < ActionController::TestCase
  setup do
    @progress = Progress.first!
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
=end