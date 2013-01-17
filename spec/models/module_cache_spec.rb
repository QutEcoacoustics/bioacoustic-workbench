require 'spec_helper'

describe Cache do
  it "should create correct cached spectrogram file name" do
  
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_87654321_1024_100000_1024_g.png'
    
    params = {"controller"=>"media", "action"=>"item", "id"=>"21EC2020-3AEA-1069-A2DD-08002B30309D", "start_offset"=>"012345678", "end_offset"=>"87654321", "channel"=>"1024", "sample_rate"=>"100000", "window"=>"1024", "colour"=>"g", "format"=>".png"}
    
    file_name = Cache::cached_spectrogram_file(params)
    
    assert url_file_name == file_name, "Expected #{url_file_name}, but was #{file_name}."
  end

  it "should create correct cached audio file name" do
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_87654321_1024_100000.mp3'
    
    params = {"controller"=>"media", "action"=>"item", "id"=>"21EC2020-3AEA-1069-A2DD-08002B30309D", "start_offset"=>"012345678", "end_offset"=>"87654321", "channel"=>"1024", "sample_rate"=>"100000",  "format"=>".mp3"}
    
    file_name = Cache::cached_audio_file(params)
    
    assert url_file_name == file_name, "Expected #{url_file_name}, but was #{file_name}."
  end

  it "should create correct original audio file name" do
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_20121026_132600.wav'
    
    params = {"controller"=>"media", "action"=>"item", "id"=>"21EC2020-3AEA-1069-A2DD-08002B30309D", "date"=>"20121026", "time"=>"132600", "format"=>".wav"}
    
    file_name = Cache::original_audio_file(params)
    
    assert url_file_name == file_name, "Expected #{url_file_name}, but was #{file_name}."
  end

  it "should ensure full paths are created correctly" do
    paths = Cache::possible_paths(['/path1/','/path2','/path3/path4'], 'thefilename.txt').sort { |a,b| a <=> b }
    assert_equal paths[0], '/path1/thefilename.txt'
    assert_equal paths[1], '/path2/thefilename.txt'
    assert_equal paths[2], '/path3/path4/thefilename.txt'
  end

  it "should ensure full paths are filtered by whether they exist or not" do
    base_path = './test/fixtures/audio'
    file_names = ['20081202-07-koala-calls.mp3','Lewins Rail Kekkek.webm',
                  'not-an-audio-file.wav','ocioncosta-lindamenina.ogg',
                  'TestAudio1.wv','TorresianCrow.wav', 'This one is not there.Imnothere']
    result = []
    file_names.each do |file_name|
      result.concat Cache::existing_paths([base_path], file_name).sort { |a,b| a <=> b }
    end
    assert_equal result.length, 6
    assert_equal result[0], './test/fixtures/audio/20081202-07-koala-calls.mp3'
    assert_equal result[1], './test/fixtures/audio/Lewins Rail Kekkek.webm'
    assert_equal result[2], './test/fixtures/audio/not-an-audio-file.wav'
    assert_equal result[3], './test/fixtures/audio/ocioncosta-lindamenina.ogg'
    assert_equal result[4], './test/fixtures/audio/TestAudio1.wv'
    assert_equal result[5], './test/fixtures/audio/TorresianCrow.wav'
  end
end