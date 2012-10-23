require 'test_helper'

class SpectrogramTest < ActiveSupport::TestCase
  include Spectrogram
  test "source and destination files exist" do
    input_path = './test/fixtures/'
    output_path = './public/tests/'
    
    audio = 'TorresianCrow.wav'
    image = 'TorresianCrow.png'
    
    input_audio = input_path + audio
    output_image = output_path + image
    
    result = Spectrogram::generate(input_audio, output_image)
    
    print result
    assert result[3]
    assert result[4]
    
    #tidy up
    File.delete output_image
  end
end