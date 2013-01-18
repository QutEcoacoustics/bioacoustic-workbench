require 'spec_helper'

describe Cache do
  it "should create correct cached spectrogram file name" do

    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_87654321_1024_100000_1024_g.png'

    params = {controller: 'media', action: 'item', id: '21EC2020-3AEA-1069-A2DD-08002B30309D', start_offset: '012345678', end_offset: '87654321', channel: '1024', sample_rate: '100000', window: '1024', colour: 'g', format: '.png'}

    file_name = Cache::cached_spectrogram_file(params)

    assert url_file_name == file_name, "Expected #{url_file_name}, but was #{file_name}."
  end

  it "should create correct cached audio file name" do
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_87654321_1024_100000.mp3'

    params = {controller: 'media', action: 'item', id: '21EC2020-3AEA-1069-A2DD-08002B30309D', start_offset: '012345678', end_offset: '87654321', channel: '1024', sample_rate: '100000',  format: '.mp3'}

    file_name = Cache::cached_audio_file(params)

    assert url_file_name == file_name, "Expected #{url_file_name}, but was #{file_name}."
  end

  it "should create correct original audio file name" do
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_20121026_132600.wav'

    params = {controller: 'media', action: 'item', id: '21EC2020-3AEA-1069-A2DD-08002B30309D', date: '20121026', time: '132600', format: '.mp3', original_format: '.wav'}

    file_name = Cache::original_audio_file(params)

    assert url_file_name == file_name, "Expected #{url_file_name}, but was #{file_name}."
  end

  it "should ensure full paths are created correctly" do
    paths = Cache::possible_paths(['/path1/','/path2','/path3/path4'], '1bd0d668-1471-4396-adc3-09ccd8fe949a_20121106_000000.wv').sort { |a,b| a <=> b }
    assert_equal '/path1/1b/1bd0d668-1471-4396-adc3-09ccd8fe949a_20121106_000000.wv', paths[0]
    assert_equal '/path2/1b/1bd0d668-1471-4396-adc3-09ccd8fe949a_20121106_000000.wv', paths[1]
    assert_equal '/path3/path4/1b/1bd0d668-1471-4396-adc3-09ccd8fe949a_20121106_000000.wv', paths[2]
  end

  it "should ensure full paths are filtered by whether they exist or not" do

    base_path = './test/fixtures/audio'
    valid_file_names = [
        '20081202-07-koala-calls.mp3',
        'Lewins Rail Kekkek.webm',
        'not-an-audio-file.wav',
        'ocioncosta-lindamenina.ogg',
        'TestAudio1.wv',
        'TorresianCrow.wav',
        '06Sibylla.asf',
        '06Sibylla.wma'
    ]
    invalid_file_names = [
        'This one is not there Imnothere.mp3',
        'anotherone-hi-cant-find-me.wav'
    ]

    # prepare for this test
    test_path = AudioHelpers::get_temp_file_path('testingonly')
    FileUtils.makedirs(test_path)

    valid_file_names.each do |file|
      target_possible_paths = Cache::possible_paths([test_path],file)
      target_possible_paths.each { |path|
        # ensure the subdirectories exist
        FileUtils.makedirs(File.dirname(path))
        # copy the file
        original_file = File.join(base_path,file)
        FileUtils.copy(original_file, path)
      }
    end

    result = []
    invalid_file_names.concat(valid_file_names).each do |file_name|
      result.concat Cache::existing_paths([test_path], file_name) #.sort { |a,b| a <=> b }
    end

    result.should =~ valid_file_names.map { |file| Cache::possible_paths([test_path],file)[0] }

    # delete files created for the test
    FileUtils.rmdir(test_path)
  end
end