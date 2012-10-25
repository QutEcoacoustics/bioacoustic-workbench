module QubarSite
  class Application
    config.media_file_config = OpenStruct.new
    
    config.media_file_config.media_file_root = File.join(Rails.root, 'media')
    
    config.media_file_config.original_audio_path = File.join(config.media_file_config.media_file_root, 'original')
    config.media_file_config.cached_image_path = File.join(config.media_file_config.media_file_root, 'cachedimages')
    config.media_file_config.cached_audio_path = File.join(config.media_file_config.media_file_root, 'cachedaudio')
  end
end