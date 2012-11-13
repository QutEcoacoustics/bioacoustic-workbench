source 'http://rubygems.org'

# core rails gem
gem 'rails', '3.2.9.rc2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'
gem 'sqlite3'

gem 'devise'
gem 'omniauth'

# for harvester to make requests to the website
gem 'rest-client'

# omniauth gems for strategies we want to use
gem 'omniauth-browserid'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'

# checks image formats using contents of the file.
gem 'ruby-imagespec'

# gems for user storage
# https://github.com/delynn/userstamp
gem 'userstamp', :git => 'https://github.com/theepan/userstamp.git'

# https://github.com/goncalossilva/rails3_acts_as_paranoid
gem 'rails3_acts_as_paranoid', '~>0.2.0'

# enumeration suport
# https://github.com/brainspec/enumerize/issues/44
gem 'enumerize', git: 'git://github.com/brainspec/enumerize.git', branch: 'master'

# GUID generation
gem 'uuidtools'

# date validation
gem 'validates_timeliness', '~> 3.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# group for running tests
group :test do
  gem 'rake', '10.0.0.beta.2'

  gem 'simplecov', :require => false

end


group :development do
  gem 'ruby-debug-base19x', '0.11.30.pre10'
  gem 'ruby-debug-ide', '>= 0.4.17.beta14'
end

group :development, :test do

  gem 'test-unit'
  gem 'ruby-prof'

  gem 'cucumber', :require => false
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'

  gem 'jasmine', '>=1.0.2.1', :git => "https://github.com/pivotal/jasmine-gem.git"
  gem 'jasminerice'
  gem 'headless', '>=0.1.0'
end

# production gems
group :production do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'
