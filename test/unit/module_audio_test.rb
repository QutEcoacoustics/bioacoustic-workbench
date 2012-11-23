require 'test_helper'

class ModuleAudioTest < ActiveSupport::TestCase
  include Audio

  test "wv file should be converted to mp3 correctly and put in the right location" do

    input = 'TestAudio1.wv' # 2 mins
    output = 'TestAudio1.mp3'

    input_audio = get_source_audio_file_path input
    output_audio = get_target_file_path output

    # delete any existing
    delete_if_exists output_audio

    assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

    modify_params = { :start_offset => 20, :end_offset => 50, :sample_rate => 11025, :format => 'mp3' }
    result = Audio.modify(input_audio, output_audio, modify_params)

    assert File.exists?(output_audio), "Target audio does not exist: #{output_audio}, #{result}"

    # ensure the output audio has content
    file_size_out = File.size? output_audio
    assert_operator file_size_out, :>, 55000
    assert_operator file_size_out, :<, 65000

    # check/compare the output audio info
    input_info = AudioFfmpeg::info_ffmpeg input_audio
    output_info = AudioFfmpeg::info_ffmpeg output_audio

    # assertions
    check_format :mp3, input_info, output_info, modify_params[:start_offset],modify_params[:end_offset]

    #tidy up
    delete_if_exists output_audio
  end

  test "wav file should be converted to mp3 correctly and put in the right location" do

    input = 'TorresianCrow.wav' # 15 sec
    output = 'TestAudio1.mp3'

    input_audio = get_source_audio_file_path input
    output_audio = get_target_file_path output

    # delete any existing
    delete_if_exists output_audio

    assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

    modify_params = { :start_offset => 3, :end_offset => 10, :sample_rate => 11025, :format => 'mp3' }
    result = Audio.modify(input_audio, output_audio,modify_params )

    assert File.exists?(output_audio), "Target audio does not exist: #{output_audio}, #{result}"

    # ensure the output audio has content
    file_size_out = File.size? output_audio
    assert_operator file_size_out, :>, 0
    assert_operator file_size_out, :<, 100000

    # check/compare the output audio info
    input_info = AudioFfmpeg::info_ffmpeg input_audio
    output_info = AudioFfmpeg::info_ffmpeg output_audio

    # assertions
    check_format :mp3, input_info, output_info, modify_params[:start_offset],modify_params[:end_offset]

    #tidy up
    delete_if_exists output_audio
  end

  test "mp3 file should be modified correctly and put in the right location" do

    input = '20081202-07-koala-calls.mp3' # 2 min 20 sec
    output = 'TestAudio1.mp3'

    input_audio = get_source_audio_file_path input
    output_audio = get_target_file_path output

    # delete any existing
    delete_if_exists output_audio

    assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

    modify_params = { :start_offset => 20, :end_offset => 110, :sample_rate => 11025, :format => 'mp3' }
    result = Audio.modify(input_audio, output_audio, modify_params)

    assert File.exists?(output_audio), "Target audio does not exist: #{output_audio}, #{result}"

    # ensure the output audio has content
    file_size_out = File.size? output_audio
    assert_operator file_size_out, :>, 175000
    assert_operator file_size_out, :<, 185000

    # check/compare the output audio info
    input_info = AudioFfmpeg::info_ffmpeg input_audio
    output_info = AudioFfmpeg::info_ffmpeg output_audio

    # assertions
    check_format :mp3, input_info, output_info, modify_params[:start_offset],modify_params[:end_offset]

    #tidy up
    delete_if_exists output_audio
  end

  private

  def check_format(output_type, input_info, output_info, start_offset, end_offset)
    # format
    assert_equal AudioFfmpeg::CODECS[output_type][:codec_name], output_info[:info][:ffmpeg]['STREAM codec_name']
    assert_equal AudioFfmpeg::CODECS[output_type][:codec_long_name], output_info[:info][:ffmpeg]['STREAM codec_long_name']
    assert_equal AudioFfmpeg::CODECS[output_type][:codec_type], output_info[:info][:ffmpeg]['STREAM codec_type']
    assert_equal AudioFfmpeg::CODECS[output_type][:format_long_name], output_info[:info][:ffmpeg]['FORMAT format_long_name']

    # duration
    assert_in_delta (end_offset - start_offset), AudioFfmpeg::parse_duration(output_info[:info][:ffmpeg]['STREAM duration']), 1, "from #{start_offset} to #{end_offset}"
  end
end