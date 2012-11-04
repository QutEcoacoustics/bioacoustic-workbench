require 'test_helper'

class AudioRecordingsControllerTest < ActionController::TestCase
  setup do
    @audio_recording = audio_recordings(:one)
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
      post :create, audio_recording: { bit_rate_bps: @audio_recording.bit_rate_bps, channels: @audio_recording.channels, data_length_bytes: @audio_recording.data_length_bytes, duration_seconds: @audio_recording.duration_seconds, media_data_hash: @audio_recording.media_data_hash, media_type: @audio_recording.media_type, notes: @audio_recording.notes, recorded_date: @audio_recording.recorded_date, sample_rate_hertz: @audio_recording.sample_rate_hertz, status: @audio_recording.status }
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
    put :update, id: @audio_recording, audio_recording: { bit_rate_bps: @audio_recording.bit_rate_bps, channels: @audio_recording.channels, data_length_bytes: @audio_recording.data_length_bytes, duration_seconds: @audio_recording.duration_seconds, media_data_hash: @audio_recording.media_data_hash, media_type: @audio_recording.media_type, notes: @audio_recording.notes, recorded_date: @audio_recording.recorded_date, sample_rate_hertz: @audio_recording.sample_rate_hertz, status: @audio_recording.status }
    assert_redirected_to audio_recording_path(assigns(:audio_recording))
  end

  test "should destroy audio_recording" do
    assert_difference('AudioRecording.count', -1) do
      delete :destroy, id: @audio_recording
    end

    assert_redirected_to audio_recordings_path
  end
end
