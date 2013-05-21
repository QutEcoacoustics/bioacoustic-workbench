source 'http://rubygems.org'

# gems from github

# a replacement for hash based formatting
# https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', :git => 'git://github.com/rails-api/active_model_serializers.git'

# enumeration suport
# https://github.com/brainspec/enumerize/issues/44
gem 'enumerize', git: 'git://github.com/brainspec/enumerize.git', branch: 'master'

# gems for user storage
# https://github.com/delynn/userstamp
gem 'userstamp', :git => 'git://github.com/theepan/userstamp.git'

#######################

# core rails gem
# temporary rollback to 3.2.8 because of this issue https://github.com/rails/rails/pull/8718
gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'jquery-rails', '2.2.1'

# disabled because the it breaks each component up into its own file - this is very slow when doing dev work
# instead a manual version was placed in vendor
#gem 'jquery-ui-rails', :git => 'git://github.com/joliss/jquery-ui-rails.git'

gem 'sqlite3', '1.3.7'

gem 'devise', '2.2.4'

gem 'cancan'

# omniauth gems for strategies we want to use
gem 'omniauth', '1.1.4'
gem 'omniauth-browserid', '0.0.1'
gem 'omniauth-facebook', '1.4.1'
gem 'omniauth-github', '1.1.0'
gem 'omniauth-google-oauth2', '0.1.17'
gem 'omniauth-openid', '1.0.1'
gem 'omniauth-twitter', '0.0.16'
gem 'omniauth-windowslive', '0.0.8.1'

# Trollop - command line args
gem 'trollop', '2.0'

# checks image formats using contents of the file.
gem 'ruby-imagespec', '0.3.1'

# https://github.com/goncalossilva/rails3_acts_as_paranoid
#gem 'rails3_acts_as_paranoid', '~>0.2'
gem 'acts_as_paranoid', '0.4.1' #, :require => 'rails3_acts_as_paranoid'

# GUID generation
gem 'uuidtools', '2.1.4'

# date validation
gem 'validates_timeliness', '3.0.14'

gem 'rubyzip', '0.9.9'

gem 'momentjs-rails', '2.0.0.1'
gem 'select2-rails', '3.3.2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '~> 1.0.3'
end

# group for running tests
group :test do
  gem 'rake', '~>10'
  gem 'simplecov', '0.7.1', :require => false

  gem 'faker', '1.1.2'
  gem 'capybara', '2.1.0'
  gem 'guard-rspec', '3.0.0'
  gem 'launchy', '2.3.0'

  # https://github.com/rails/rails/issues/7906#issuecomment-9401059
  # this must be in the test group, causes issue when run in development
  gem 'factory_girl_rails', '4.2.1'
end

group :development do
  #gem 'linecache19', '>= 0.5.13', :git => 'git://github.com/robmathews/linecache19-0.5.13.git'
  #gem 'ruby-debug-base19x', '>= 0.11.30.pre10'
  #gem 'ruby-debug-ide', '>= 0.4.17.beta14'

  gem 'thin', '1.5.1'
end

group :development, :test do

  gem 'test-unit', '2.5.5'
  gem 'mocha', '~>0.13', require: false
  gem 'rspec', '2.13.0'
  gem 'rspec-rails', '2.13.2'

  gem 'shoulda', '3.5.0'
  gem 'shoulda-matchers', '~>1.5.6'

  gem 'ruby-prof', '0.13.0'

  gem 'cucumber', '1.3.1', :require => false
  gem 'cucumber-rails', '1.3.1', :require => false
  gem 'database_cleaner', '1.0.1'

  gem 'jasmine', '1.3.2', :git => 'git://github.com/pivotal/jasmine-gem.git'
  gem 'jasminerice', '0.0.10'
  gem 'headless', '1.0.1'

  gem 'rspec-deep-matchers', '0.0.2'
end

# production gems
group :production do
  gem 'pg', '0.15.1'
  gem 'activerecord-postgresql-adapter', '0.0.1'
  gem 'bundler', '1.3.5'
  gem 'execjs', '1.4.0'
  gem 'libv8', '~>3.16.14', :platforms => :ruby
  gem 'therubyracer', '0.11.4', :platforms => :ruby

  gem 'unicorn', '4.6.2', :platforms => :ruby
  # use typhosus instead of net/http to try to solve 'wrong status line' error.
  gem 'typhoeus', '0.6.3', :platforms => :ruby
end

# unicorn depends on kgio which is not supported on windows
#if !RUBY_PLATFORM =~ /mswin32/
#  gem 'unicorn', group: :production
#end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '2.15.4'
gem 'rvm-capistrano', '1.3.0'
