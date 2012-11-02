module QubarSite
  
  def set(key, value)
    QubarSite::Application.instance_variable_set
  end
  
  class Application
    config.media_file_config = OpenStruct.new
    
    config.media_file_config.original_audio_paths = [File.join(Rails.root, 'media', 'original1'), File.join(Rails.root, 'media', 'original2')]
    config.media_file_config.cached_spectrogram_paths = [File.join(Rails.root, 'media', 'cachedimages2'), File.join(Rails.root, 'media', 'cachedimages1')]
    config.media_file_config.cached_audio_paths = [File.join(Rails.root, 'media', 'cachedaudio'), File.join(Rails.root, 'media', 'cachedaudio2')]
    
    config.media_file_config.cached_audio_defaults = [
        {:channel => 0, :sample_rate => 22050, :format => '.webma'},
        {:channel => 0, :sample_rate => 22050, :format => '.mp3'},
        {:channel => 0, :sample_rate => 22050, :format => '.ogg'}
    ]
    config.media_file_config.cached_spectrogram_defaults = [
        {:channel => 0, :sample_rate => 22050, :window => 512, :colour => 'a', :format => '.png'}
    ]
  end
end