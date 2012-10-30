require 'test_helper'

class SpectrogramModuleTest < ActiveSupport::TestCase
  include Spectrogram
  test "source and destination files exist" do
    input_path = './test/fixtures/'
    output_path = './public/tests/'
    
    audio = 'TorresianCrow.wav'
    image = 'TorresianCrow.png'
    
    input_audio = input_path + audio
    output_image = output_path + image
    
    result = Spectrogram::generate(input_audio, output_image, [])
    
    # ensure source and destination files exist
    assert result[3]
    assert result[4]
    
    # ensure the input audio has content
    file_size_in = File.size? input_audio
    assert_operator file_size_in, :>=, 1300000
    
    # ensure the output image has content
    file_size_out = File.size? output_image
    assert_operator file_size_out, :>, 100000
    
    #tidy up
    File.delete output_image
  end
  
  test "using an invalid source file" do
    
  end
end