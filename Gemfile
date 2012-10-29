source 'http://rubygems.org'

# core rails gem
gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'
gem 'sqlite3'

# checks image formats using contents of the file.
gem 'ruby-imagespec'

# gems for user storage
# https://github.com/delynn/userstamp
gem 'userstamp', :git => 'https://github.com/theepan/userstamp.git'

# https://github.com/goncalossilva/rails3_acts_as_paranoid
gem "rails3_acts_as_paranoid", "~>0.2.0"

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
  gem 'rake'
end

group :development do
  #gem 'linecache19', '0.5.13'
  #gem 'ruby-debug-base19', '0.11.26'
  #gem 'ruby-debug19', :require => 'ruby-debug'
  #gem 'debugger'
  gem 'test-unit'
  gem 'ruby-prof'
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
