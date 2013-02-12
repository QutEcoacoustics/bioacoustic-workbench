require_relative '../settings.rb'
require_relative '../../lib/modules/logger'

module BawSite

  def set(key, value)
    BawSite::Application.instance_variable_set
  end

  class Application

    # this is for Rails, will not work for harvester
    base_dir = File.join(Rails.root, 'media')

    Logging.set_logger(Rails.logger)

    config.media_file_config = OpenStruct.new

    config.media_file_config.original_audio_paths = SharedSettings.settings[:original_audio_paths] = SharedSettings.settings[:original_audio_paths].collect { |item| File.join(base_dir, item) }
    config.media_file_config.cached_spectrogram_paths = SharedSettings.settings[:cached_spectrogram_paths] = SharedSettings.settings[:cached_spectrogram_paths].collect { |item| File.join(base_dir, item) }
    config.media_file_config.cached_audio_paths = SharedSettings.settings[:cached_audio_paths] = SharedSettings.settings[:cached_audio_paths].collect { |item| File.join(base_dir, item) }

    config.media_file_config.cached_audio_defaults = SharedSettings.settings[:cached_audio_defaults]
    config.media_file_config.cached_spectrogram_defaults = SharedSettings.settings[:cached_spectrogram_defaults]


    config.custom_info = OpenStruct.new


    ##################
    # File devise.rb #
    ##################

    # config.pepper (128 chars)
    config.custom_info.pepper = '128 char random pepper 128 char random pepper'

    # config.omniauth :browser_id, :audience_url => 'http://localhost:3000'
    config.custom_info.browser_id = {name: :browser_id, settings: {audience_url: 'http://localhost:3000'}}

    # config.omniauth :google_oauth2, 'google id', 'google secret', {access_type: 'online', approval_prompt: ''}
    # change this at https://code.google.com/apis/console/
    config.custom_info.google_oauth2 = {name: :google_oauth2, id: 'google id', secret: 'google secret', settings: {access_type: 'online', approval_prompt: ''}}

    # config.omniauth :facebook, 'APP_ID', 'APP_SECRET', :scope => 'email'
    # change this at https://developers.facebook.com/apps/
    config.custom_info.facebook = {name: :facebook, id: 'fb id', secret: 'fb secret', settings: {scope: 'email'}}

    # config.omniauth :twitter, "consumer_key", "consumer_secret"
    # change this at https://dev.twitter.com/apps
    config.custom_info.twitter = {name: :twitter, id: 'twitter key', secret: 'twitter secret'}

    # live id
    # documentation http://msdn.microsoft.com/en-us/library/live/hh826543.aspx#rest
    # change this at https://manage.dev.live.com/Applications
    config.custom_info.windowslive = {name: :windowslive, id: 'live client id', secret: 'live id secret', settings: {scope: 'wl.basic'}}

    # github API http://developer.github.com/v3/oauth/
    config.custom_info.github = {name: :github, id: 'live client id', secret: 'live id secret', settings: {scope: 'user'}}

    # config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
    config.custom_info.mailer_sender = {email: "please-change-me-at-config-initializers-devise@example.com"}

    ########################
    # File secret_token.rb #
    ########################

    # BawSite::Application.config.secret_token
    config.custom_info.secret_token = 'some long secret token - at least 30 chars, all random'

  end
end