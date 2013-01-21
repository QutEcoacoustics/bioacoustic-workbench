source 'http://rubygems.org'

# core rails gem
# temporary roleback to 3.2.8 because of this issue https://github.com/rails/rails/pull/8718
gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'

# disabled because the it breaks each component up into its own file - this is very slow when doing dev work
# instead a manual version was placed in vendor
#gem 'jquery-ui-rails', :git => 'git://github.com/joliss/jquery-ui-rails.git'

gem 'sqlite3'

gem 'devise'
gem 'omniauth'
gem 'cancan'

# omniauth gems for strategies we want to use
gem 'omniauth-browserid'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-openid'
gem 'omniauth-github'

# Trollop - command line args
gem 'trollop'

# checks image formats using contents of the file.
gem 'ruby-imagespec'

# gems for user storage
# https://github.com/delynn/userstamp
gem 'userstamp', :git => 'git://github.com/theepan/userstamp.git'

# https://github.com/goncalossilva/rails3_acts_as_paranoid
#gem 'rails3_acts_as_paranoid', '~>0.2'
gem 'acts_as_paranoid', '~> 0.4.0' #, :require => 'rails3_acts_as_paranoid'

# enumeration suport
# https://github.com/brainspec/enumerize/issues/44
gem 'enumerize', git: 'git://github.com/brainspec/enumerize.git', branch: 'master'

# GUID generation
gem 'uuidtools'

# date validation
gem 'validates_timeliness', '~> 3.0'

# a replacement for hash based formatting
# https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', :git => "git://github.com/rails-api/active_model_serializers.git"

gem 'rubyzip'

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
  gem 'rake', '>=10'
  gem 'simplecov', :require => false

  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

group :development do
  #gem 'linecache19', '>= 0.5.13', :git => 'git://github.com/robmathews/linecache19-0.5.13.git'
  #gem 'ruby-debug-base19x', '>= 0.11.30.pre10'
  #gem 'ruby-debug-ide', '>= 0.4.17.beta14'

  gem 'thin'
end

group :development, :test do

  gem 'test-unit'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda'

  gem 'ruby-prof'

  gem 'cucumber', :require => false
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'

  gem 'jasmine', '>=1.0.2.1', :git => "git://github.com/pivotal/jasmine-gem.git"
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
