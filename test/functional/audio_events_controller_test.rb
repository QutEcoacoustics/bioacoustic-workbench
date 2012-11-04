require 'test_helper'

class AudioEventsControllerTest < ActionController::TestCase
  setup do
    @audio_event = audio_events(:one)
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
      post :create, audio_event: { audio_recording_id: @audio_event.audio_recording_id, end_time_seconds: @audio_event.end_time_seconds, high_frequency_hertz: @audio_event.high_frequency_hertz, is_reference: @audio_event.is_reference, low_frequency_hertz: @audio_event.low_frequency_hertz, start_time_seconds: @audio_event.start_time_seconds }
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
