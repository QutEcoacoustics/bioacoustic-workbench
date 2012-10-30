require 'test_helper'

class CacheModuleTest < ActiveSupport::TestCase
  include Cache
  test "creating correct cached spectrogram file name" do
  
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_87654321_1024_100000_1024_g.png'
    
    params = {"controller"=>"media", "action"=>"item", "id"=>"21EC2020-3AEA-1069-A2DD-08002B30309D", "start_offset"=>"012345678", "end_offset"=>"87654321", "channel"=>"1024", "sample_rate"=>"100000", "window"=>"1024", "colour"=>"g", "format"=>".png"}
    
    file_name = Cache::cached_spectrogram_file(params)
    
    assert url_file_name == file_name
  end
  
  test "creating correct cached audio file name" do
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_87654321_1024_100000.mp3'
    
    params = {"controller"=>"media", "action"=>"item", "id"=>"21EC2020-3AEA-1069-A2DD-08002B30309D", "start_offset"=>"012345678", "end_offset"=>"87654321", "channel"=>"1024", "sample_rate"=>"100000",  "format"=>".mp3"}
    
    file_name = Cache::cached_audio_file(params)
    
    assert url_file_name == file_name
  end
  
  test "creating correct original audio file name" do
    url_file_name = '21EC2020-3AEA-1069-A2DD-08002B30309D_20121026_132600.wav'
    
    params = {"controller"=>"media", "action"=>"item", "id"=>"21EC2020-3AEA-1069-A2DD-08002B30309D", "date"=>"20121026", "time"=>"132600", "format"=>".wav"}
    
    file_name = Cache::original_audio_file(params)
    
    assert url_file_name == file_name
  end
  
end