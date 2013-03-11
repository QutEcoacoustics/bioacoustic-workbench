require_relative '../settings.rb'
require_relative '../../lib/modules/logger'

BawSite::Application.config.custom_base_dir = File.join(Rails.root, 'media')

# audio storage paths
BawSite::Application.config.custom_original_audio_paths =
    SharedSettings.settings[:original_audio_paths] =
        SharedSettings.settings[:original_audio_paths].collect { |item| File.join(BawSite::Application.config.custom_base_dir, item) }

BawSite::Application.config.custom_cached_spectrogram_paths =
    SharedSettings.settings[:cached_spectrogram_paths] =
        SharedSettings.settings[:cached_spectrogram_paths].collect { |item| File.join(BawSite::Application.config.custom_base_dir, item) }

BawSite::Application.config.custom_cached_audio_paths =
    SharedSettings.settings[:cached_audio_paths] =
        SharedSettings.settings[:cached_audio_paths].collect { |item| File.join(BawSite::Application.config.custom_base_dir, item) }

BawSite::Application.config.custom_cached_audio_defaults = SharedSettings.settings[:cached_audio_defaults]
BawSite::Application.config.custom_cached_spectrogram_defaults = SharedSettings.settings[:cached_spectrogram_defaults]

BawSite::Application.config.custom_experiment_path = File.join(BawSite::Application.config.custom_base_dir, 'experiments')

########################
# File secret_token.rb #
########################

BawSite::Application.config.secret_token = 'some long secret token - at least 30 chars, all random'

##################
# File devise.rb #
##################

# config.pepper (128 chars)
BawSite::Application.config.custom_pepper = '128 char random pepper 128 char random pepper'

# config.omniauth :browser_id, :audience_url => 'http://localhost:3000'
BawSite::Application.config.custom_browser_id = {name: :browser_id, settings: {audience_url: 'http://localhost:3000'}}

# config.omniauth :google_oauth2, 'google id', 'google secret', {access_type: 'online', approval_prompt: ''}
# change this at https://code.google.com/apis/console/
BawSite::Application.config.custom_google_oauth2 = {name: :google_oauth2, id: 'google id', secret: 'google secret', settings: {access_type: 'online', approval_prompt: ''}}

# config.omniauth :facebook, 'APP_ID', 'APP_SECRET', :scope => 'email'
# change this at https://developers.facebook.com/apps/
BawSite::Application.config.custom_facebook = {name: :facebook, id: 'fb id', secret: 'fb secret', settings: {scope: 'email'}}

# config.omniauth :twitter, "consumer_key", "consumer_secret"
# change this at https://dev.twitter.com/apps
BawSite::Application.config.custom_twitter = {name: :twitter, id: 'twitter key', secret: 'twitter secret'}

# live id
# documentation http://msdn.microsoft.com/en-us/library/live/hh826543.aspx#rest
# change this at https://manage.dev.live.com/Applications
BawSite::Application.config.custom_windowslive = {name: :windowslive, id: 'live client id', secret: 'live id secret', settings: {scope: 'wl.basic'}}

# github API http://developer.github.com/v3/oauth/
# change this at https://github.com/settings/applications
BawSite::Application.config.custom_github = {name: :github, id: 'live client id', secret: 'live id secret', settings: {scope: 'user'}}

# config.mailer_sender = "please-change-me-at-config-initializers-custom_configs@example.com"
puts 'setting custom mailer sender'
BawSite::Application.config.custom_mailer_sender = {email: "please-change-me-at-config-initializers-custom_configs@example.com"}

module BawSite
  class Application

    Logging.set_logger(Rails.logger)

    # set the host domain for this website
    def default_url_options
      if Rails.env.production?
        {:host => 'http://your.domain'}
      else
        {}
      end
    end

  end
end