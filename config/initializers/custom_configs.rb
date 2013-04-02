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

################################
# Proxy and site-wide settings #
################################

# Set proxy
# to check if proxy works, use rails console:  Faraday.new('http://google.com', request: {timeout: 15}).get
# might need to set ssl cert path as well
ENV['http_proxy'] ||= ENV['HTTP_PROXY'] ||= ENV['https_proxy'] ||= ENV['HTTPS_PROXY'] ||= nil

# proxy settings
BawSite::Application.config.custom_proxy = ENV['http_proxy']

# ssl settings
BawSite::Application.config.custom_ssl_cert_path = nil

BawSite::Application.config.custom_base_domain = 'localhost'
BawSite::Application.config.custom_base_port = '3000'
BawSite::Application.config.custom_base_domain_and_port = BawSite::Application.config.custom_base_domain+':'+BawSite::Application.config.custom_base_port
BawSite::Application.config.custom_full_domain = 'http://' + BawSite::Application.config.custom_base_domain_and_port

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
BawSite::Application.config.custom_browser_id = {name: :browser_id, settings: {audience_url: BawSite::Application.config.custom_full_domain, proxy: BawSite::Application.config.custom_proxy}}

# config.omniauth :google_oauth2, 'google id', 'google secret', {access_type: 'online', approval_prompt: ''}
# change this at https://code.google.com/apis/console/
BawSite::Application.config.custom_google_oauth2 = {name: :google_oauth2, id: 'google id', secret: 'google secret', settings: {access_type: 'online', approval_prompt: '', proxy: BawSite::Application.config.custom_proxy}}

# config.omniauth :facebook, 'APP_ID', 'APP_SECRET', :scope => 'email'
# change this at https://developers.facebook.com/apps/
BawSite::Application.config.custom_facebook = {name: :facebook, id: 'fb id', secret: 'fb secret', settings: {scope: 'email', proxy: BawSite::Application.config.custom_proxy}}

# config.omniauth :twitter, "consumer_key", "consumer_secret"
# change this at https://dev.twitter.com/apps
BawSite::Application.config.custom_twitter = {name: :twitter, id: 'twitter key', secret: 'twitter secret', settings: {proxy: BawSite::Application.config.custom_proxy}}

# live id
# documentation http://msdn.microsoft.com/en-us/library/live/hh826543.aspx#rest
# change this at https://manage.dev.live.com/Applications
BawSite::Application.config.custom_windowslive = {name: :windowslive, id: 'live client id', secret: 'live id secret', settings: {scope: 'wl.basic', proxy: BawSite::Application.config.custom_proxy}}

# github API http://developer.github.com/v3/oauth/
# change this at https://github.com/settings/applications
BawSite::Application.config.custom_github = {name: :github, id: 'live client id', secret: 'live id secret', settings: {scope: 'user', proxy: BawSite::Application.config.custom_proxy}}

# config.mailer_sender = "please-change-me-at-config-initializers-custom_configs@example.com"
puts 'setting custom mailer sender'
BawSite::Application.config.custom_mailer_sender = {email: "please-change-me-at-config-initializers-custom_configs@example.com"}

# set the full host for OmniAuth
OmniAuth.config.full_host = BawSite::Application.config.custom_full_domain

# set the host domain for this website
BawSite::Application.config.action_mailer.default_url_options = { :host => BawSite::Application.config.custom_base_domain_and_port  }

###############################
# Patch for Faraday for proxy #
###############################

# http://stackoverflow.com/questions/11948656/omniauth-google-faraday-behind-the-proxy-how-setup-proxy
require 'faraday'
module OAuth2
  # The OAuth2::Client class
  class Client
    # The Faraday connection object
    def connection
      options[:connection_opts].merge!({:proxy => BawSite::Application.config.custom_proxy})
      @connection ||= begin
        conn = Faraday.new(site, options[:connection_opts])
        conn.build do |b|
          options[:connection_build].call(b)
        end if options[:connection_build]
        conn
      end
    end
  end
end