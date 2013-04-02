# Load the rails application
require File.expand_path('../application', __FILE__)

# Load certificate bundler
OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"

# Initialize the rails application
BawSite::Application.initialize!
