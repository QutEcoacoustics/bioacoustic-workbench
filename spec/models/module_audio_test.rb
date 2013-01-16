require 'test_helper'

class ModuleAudioTest < ActiveSupport::TestCase
  include Audio

  test "segmenting and converting audio files" do
    files_to_test.each do |file|
      target_formats.each do |format|

        current_file = file[:name]
        input_audio = get_source_audio_file_path current_file

        base_file_name = File.basename(current_file)
        output_file = File.extname(base_file_name).reverse.chomp('.').reverse
        output_audio = get_target_file_path output_file

        # delete any existing
        delete_if_exists output_audio

        assert File.exists?(input_audio), "Source audio file does not exist: #{input_audio}"

        modify_params = { :start_offset => 5, :end_offset => 12, :sample_rate => 11025, :format => format }
        result = Audio.modify(input_audio, output_audio, modify_params)

        assert File.exists?(output_audio), "Target audio does not exist: #{output_audio}, #{result}"

        # ensure the output audio has content
        #file_size_out = File.size? output_audio

        # check/compare the output audio info
        input_info = Audio::info input_audio
        output_info = Audio::info output_audio

        # assertions
        #check_format :mp3, input_info, output_info, modify_params[:start_offset],modify_params[:end_offset]

        #tidy up
        delete_if_exists output_audio
      end
    end
  end

=begin
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
=end

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

  def target_formats
    %w(webma mp3 wav)
  end

  def files_to_test
    [
        {
            :name => '20081202-07-koala-calls.mp3',
            :sample_rate => 44100,
            :duration => 140,
            :stream_bit_rate => 64000,
            :format_bit_rate => 64000,
            :codec_name => 'mp3',
            :codec_type => 'audio',
            :codec_long_name => 'MP3 (MPEG audio layer 3)',
            :format_name => 'mp3',
            :format_long_name => 'MP2/3 (MPEG audio layer 2/3)'
        },
        {
            :name => 'Lewins Rail Kekkek.webm',
            :sample_rate => 22050,
            :duration => 60,
            :stream_bit_rate => nil,
            :format_bit_rate => 43032,
            :codec_name => 'vorbis',
            :codec_type => 'audio',
            :codec_long_name => 'Vorbis',
            :format_name => 'matroska,webm',
            :format_long_name => 'Matroska / WebM'
        },
        {
            :name => 'not-an-audio-file.wav',
            :sample_rate => nil,
            :duration => nil,
            :stream_bit_rate => nil,
            :format_bit_rate => nil,
            :codec_name => nil,
            :codec_type => nil,
            :codec_long_name => nil,
            :format_name => nil,
            :format_long_name => nil
        },
        {
            :name => 'ocioncosta-lindamenina.ogg',
            :sample_rate => 32000,
            :duration => 152,
            :stream_bit_rate => 112000,
            :format_bit_rate => 83953,
            :codec_name => 'vorbis',
            :codec_type => 'audio',
            :codec_long_name => 'Vorbis',
            :format_name => 'ogg',
            :format_long_name => 'Ogg'
        },
        {
            :name => 'TestAudio1.wv',
            :sample_rate => 22050,
            :duration => 120,
            :stream_bit_rate => nil,
            :format_bit_rate => 170678,
            :codec_name => 'wavpack',
            :codec_type => 'audio',
            :codec_long_name => 'WavPack',
            :format_name => 'wv',
            :format_long_name => 'WavPack'
        },
        {
            :name => 'TorresianCrow.wav',
            :sample_rate => 44100,
            :duration => 15,
            :stream_bit_rate => 705600,
            :format_bit_rate => 705622,
            :codec_name => 'pcm_s16le',
            :codec_type => 'audio',
            :codec_long_name => 'PCM signed 16-bit little-endian',
            :format_name => 'wav',
            :format_long_name => 'WAV / WAVE (Waveform Audio)'
        }
    ]
  end
end