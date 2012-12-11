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

  class CookieFilter
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      # use only one of the next two lines

      # this will remove ALL cookies from the response
      headers.delete 'Set-Cookie'
      # this will remove just your session cookie
      #Rack::Utils.delete_cookie_header!(headers, '_app-name_session')

      [status, headers, body]
    end
  end
end

# disable all cookies. This is probably not good :(
# see http://stackoverflow.com/a/8072642/31567
#Rails.application.config.middleware.insert_after ::ActionDispatch::Cookies, BawSite::CookieFilter

