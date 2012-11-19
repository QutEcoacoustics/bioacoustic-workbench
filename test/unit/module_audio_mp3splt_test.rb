require 'test_helper'

class ModuleAudioMp3spltTest < ActiveSupport::TestCase
  include AudioMp3splt

  test "mp3 file should be segmented correctly" do

    input = '20081202-07-koala-calls.mp3'
    output = 'output.mp3'
    start_offset = 20
    end_offset = 100

    input_audio = get_source_audio_file_path input
    output_audio = get_target_file_path output

    # delete any existing
    delete_if_exists output_audio

    assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

    result = AudioMp3splt.modify_mp3splt(input_audio, output_audio, {:start_offset => start_offset, :end_offset => end_offset })

    assert File.exists?(output_audio), "Target audio does not exist: #{output_audio}, #{result}"

    # check/compare the output audio info
    input_info = Audio::info input_audio
    output_info = Audio::info output_audio

    # duration
    expected_duration = Time.at(end_offset - start_offset) - Time.now.utc_offset
    expected_duration_str = expected_duration.strftime('%-k:%M:%S.%6N')
    assert_equal expected_duration_str, output_info[:info][:ffmpeg]['STREAM duration']

    #tidy up
    delete_if_exists output_audio
  end

end