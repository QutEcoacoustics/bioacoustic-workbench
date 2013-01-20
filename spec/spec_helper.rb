require 'net/http'
require 'json'

require 'simplecov'
SimpleCov.start

require 'database_cleaner'
require 'enumerize'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false # was true by default

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:suite) do
    #DatabaseCleaner.strategy = :truncation

    # https://github.com/bmabey/database_cleaner
    # http://stackoverflow.com/a/5964483
    # http://stackoverflow.com/a/9248602
    # I found the SQLite exception solution was to remove the clean_with(:truncation) and change the strategy entirely to DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    # MOVED SEED RUNNING BELOW
    # SEEDS ONLY AVAILABLE FOR CONTROLLER TESTS
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # mixin core methods
  config.include FactoryGirl::Syntax::Methods

  # https://github.com/plataformatec/devise
  # for signing in
  config.include Devise::TestHelpers, :type => :controller

  config.before(:all, :type => :controller) do
    Rack::MockRequest::DEFAULT_ENV['devise.mapping']= Devise.mappings[:user]

    # support for running seed data with tests
    load "#{Rails.root}/db/seeds.rb"
  end

  config.before(:each, :type => :controller) do
    sign_in :user, User.first
  end

  config.after(:all, :type => :controller) do
    Rack::MockRequest::DEFAULT_ENV['devise.mapping']= Devise.mappings[:user]
  end

end


