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
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AudioRecording, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :notes => {},
          :bit_rate_bps => nil,
          :channels => nil,
          :data_length_bytes => nil,
          :duration_seconds => nil,
          :file_hash => nil,
          :media_type => nil,
          :recorded_date => nil,
          :sample_rate_hertz => nil,
          :site_id => nil,
          :status => 'new',
          :uploader_id => nil,
          :uuid => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, AudioRecording
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AudioRecording.count
        @response_body = json({ post: :create, audio_recording: build(:audio_recording).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, AudioRecording
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AudioRecording.count
        @response_body = json({ post: :create, audio_recording: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, AudioRecording, {:uploader_id=>["can't be blank"], :recorded_date=>["can't be blank", "is not a valid date"], :site=>["can't be blank"], :duration_seconds=>["can't be blank", "is not a number"], :sample_rate_hertz=>["is not a number"], :channels=>["can't be blank", "is not a number"], :bit_rate_bps=>["is not a number"], :media_type=>["can't be blank"], :data_length_bytes=>["can't be blank", "is not a number"], :file_hash=>["can't be blank"]}
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