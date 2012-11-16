require 'test_helper'

class ModuleAudioWavpackTest < ActiveSupport::TestCase
  include AudioWavpack

  test "wv file should be converted to wav correctly" do

    input = 'TestAudio1.wv'
    output = 'TestAudio1.wav'

    input_audio = get_source_audio_file_path input
    output_audio = get_target_file_path output

    # delete any existing
    delete_if_exists output_audio

    assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

    result = AudioWavpack.modify_wavpack(input_audio, output_audio, { })

    assert File.exists?(output_audio), "Target audio does not exist: #{output_audio}, #{result}"

    # ensure the output audio has content
    file_size_out = File.size? output_audio
    assert_operator file_size_out, :>, 2560180

    # check/compare the output audio info
    input_info = AudioFfmpeg::info_ffmpeg input_audio
    output_info = AudioFfmpeg::info_ffmpeg output_audio

    # format
    assert_equal output_info[:info][:ffmpeg]['STREAM codec_name'], AudioFfmpeg::CODECS[:wav][:codec_name]
    assert_equal output_info[:info][:ffmpeg]['STREAM codec_long_name'], AudioFfmpeg::CODECS[:wav][:codec_long_name]
    assert_equal output_info[:info][:ffmpeg]['STREAM codec_type'], AudioFfmpeg::CODECS[:wav][:codec_type]
    assert_equal output_info[:info][:ffmpeg]['FORMAT format_long_name'], AudioFfmpeg::CODECS[:wav][:format_long_name]

    # duration
    assert_equal input_info[:info][:ffmpeg]['STREAM duration'], output_info[:info][:ffmpeg]['STREAM duration']

    #tidy up
    delete_if_exists output_audio
  end

  test "wv file should be segmented and converted to wav correctly" do
    input = 'TestAudio1.wv'
    output = 'TestAudio1.wav'
    start_offset = 20
    end_offset = 100

    input_audio = get_source_audio_file_path input
    output_audio = get_target_file_path output

    # delete any existing
    delete_if_exists output_audio

    assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

    result = AudioWavpack.modify_wavpack(input_audio, output_audio, {:start_offset => start_offset, :end_offset => end_offset })

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