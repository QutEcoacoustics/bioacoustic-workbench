<<<<<<< HEAD
module QubarSite
  class Application
    config.media_file_config = OpenStruct.new
    
    config.media_file_config.original_audio_paths = [File.join(Rails.root, 'media', 'original1'), File.join(Rails.root, 'media', 'original2')]
    config.media_file_config.cached_spectrogram_paths = [File.join(Rails.root, 'media', 'cachedimages2'), File.join(Rails.root, 'media', 'cachedimages1')]
    config.media_file_config.cached_audio_paths = [File.join(Rails.root, 'media', 'cachedaudio'), File.join(Rails.root, 'media', 'cachedaudio2')]
    
    config.media_file_config.cached_audio_defaults = [{:channel => 0, :sample_rate => 22050, :format => '.webma'}, {:channel => 0, :sample_rate => 22050, :format => '.mp3'}]
    config.media_file_config.cached_spectrogram_defaults = [{:channel => 0, :sample_rate => 22050, :window => 512, :colour => 'a', :format => '.png'}]
    
  end
end
=======
require_relative '../settings.rb'
>>>>>>> ef586d050eeaea67953ee5f56b1f07d772961e13
