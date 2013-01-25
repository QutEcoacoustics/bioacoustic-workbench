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
      @item = create(:progress)
      @response_body = json({ get: :show, id: @item.id })
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
        test = convert_model(:create, :progress, build(:progress))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, Progress
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Progress.count
        test = convert_model(:create, :progress, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, Progress, {:offset_list=>["can't be blank"], :activity=>["can't be blank"], :saved_search_id=>["can't be blank"], :audio_recording_id=>["can't be blank"], :creator_id=>["can't be blank"], :start_offset_seconds=>["can't be blank", "is not a number"], :end_offset_seconds=>["can't be blank", "is not a number"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:progress)
        @changed.start_offset_seconds = 500.0
        test = convert_model(:update, :progress, @changed)
        @response_body = json_empty_body(test)
      end

      it_should_behave_like :a_valid_update_api_call, Progress, :start_offset_seconds
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:progress)
        @old_value = @initial.start_offset_seconds
        @initial.start_offset_seconds = -10.0
        test = convert_model(:update, :progress, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, Progress, :start_offset_seconds, {:start_offset_seconds=>["must be greater than or equal to 0"]}
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