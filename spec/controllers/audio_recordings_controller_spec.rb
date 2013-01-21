require 'spec_helper'

describe AudioRecordingsController do
  describe "GET #index" do
    it "populates a list"
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AudioRecording
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

class AudioRecordingsControllerTest < ActionController::TestCase
  setup do
    @audio_recording = AudioRecording.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:audio_recordings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create audio_recording" do
    assert_difference('AudioRecording.count') do
      post :create, audio_recording: { bit_rate_bps: @audio_recording.bit_rate_bps, channels: @audio_recording.channels, data_length_bytes: @audio_recording.data_length_bytes, duration_seconds: @audio_recording.duration_seconds, file_hash: @audio_recording.file_hash, media_type: @audio_recording.media_type, notes: @audio_recording.notes, recorded_date: @audio_recording.recorded_date, sample_rate_hertz: @audio_recording.sample_rate_hertz, status: @audio_recording.status }
    end

    assert_redirected_to audio_recording_path(assigns(:audio_recording))
  end

  test "should show audio_recording" do
    get :show, id: @audio_recording
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @audio_recording
    assert_response :success
  end

  test "should update audio_recording" do
    put :update, id: @audio_recording, audio_recording: { bit_rate_bps: @audio_recording.bit_rate_bps, channels: @audio_recording.channels, data_length_bytes: @audio_recording.data_length_bytes, duration_seconds: @audio_recording.duration_seconds, file_hash: @audio_recording.file_hash, media_type: @audio_recording.media_type, notes: @audio_recording.notes, recorded_date: @audio_recording.recorded_date, sample_rate_hertz: @audio_recording.sample_rate_hertz, status: @audio_recording.status }
    assert_redirected_to audio_recording_path(assigns(:audio_recording))
  end

  test "should destroy audio_recording" do
    assert_difference('AudioRecording.count', -1) do
      delete :destroy, id: @audio_recording
    end

    assert_redirected_to audio_recordings_path
  end
end
=end