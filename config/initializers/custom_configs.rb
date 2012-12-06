require_relative '../settings.rb'

module BawSite

  def set(key, value)
    BawSite::Application.instance_variable_set
  end

  class Application

    # this is for Rails, will not work for harvester
    base_dir = File.join(Rails.root, 'media')

    config.media_file_config = OpenStruct.new

    config.media_file_config.original_audio_paths = SharedSettings.settings[:original_audio_paths] = SharedSettings.settings[:original_audio_paths].collect{ |item| File.join(base_dir, item) }
    config.media_file_config.cached_spectrogram_paths = SharedSettings.settings[:cached_spectrogram_paths] = SharedSettings.settings[:cached_spectrogram_paths].collect{ |item| File.join(base_dir, item) }
    config.media_file_config.cached_audio_paths = SharedSettings.settings[:cached_audio_paths] = SharedSettings.settings[:cached_audio_paths].collect{ |item| File.join(base_dir, item) }

    config.media_file_config.cached_audio_defaults = SharedSettings.settings[:cached_audio_defaults]
    config.media_file_config.cached_spectrogram_defaults = SharedSettings.settings[:cached_spectrogram_defaults]
  end
end