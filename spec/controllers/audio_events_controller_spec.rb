require 'spec_helper'

describe AudioEventsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :a_standard_api_call, AudioEvent
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

class AudioEventsControllerTest < ActionController::TestCase
  setup do
    @audio_event = AudioEvent.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:audio_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create audio_event" do

    assert_difference('AudioEvent.count') do
      post :create, audio_event: { audio_recording_id: @audio_event.audio_recording_id, end_time_seconds: @audio_event.end_time_seconds,
                                   high_frequency_hertz: @audio_event.high_frequency_hertz, is_reference: @audio_event.is_reference,
                                   low_frequency_hertz: @audio_event.low_frequency_hertz, start_time_seconds: @audio_event.start_time_seconds }
    end

    assert_redirected_to audio_event_path(assigns(:audio_event))
  end

  test "should show audio_event" do
    get :show, id: @audio_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @audio_event
    assert_response :success
  end

  test "should update audio_event" do
    put :update, id: @audio_event, audio_event: { end_time_seconds: @audio_event.end_time_seconds, high_frequency_hertz: @audio_event.high_frequency_hertz, is_reference: @audio_event.is_reference, low_frequency_hertz: @audio_event.low_frequency_hertz, start_time_seconds: @audio_event.start_time_seconds }
    assert_redirected_to audio_event_path(assigns(:audio_event))
  end

  test "should destroy audio_event" do
    assert_difference('AudioEvent.count', -1) do
      delete :destroy, id: @audio_event
    end

    assert_redirected_to audio_events_path
  end
end
=end