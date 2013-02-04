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
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

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
    # I found the SQLite exception solution was to remove the clean_with(:truncation) and
    # change the strategy entirely to DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    # MOVED SEED RUNNING BELOW
    # SEEDS ONLY AVAILABLE FOR CONTROLLER TESTS
  end

  config.before(:all) do |test|

  end

  config.before(:each) do |test|
    DatabaseCleaner.start

    full_example_description = test.example.full_description
    full_example_description = full_example_description+' ('+test.example.description+').' if !full_example_description.include?(test.example.description)

    ::Rails.logger.info("\r\n#{'-' * (full_example_description.length)}\r\n#{full_example_description}\r\n#{'-' * (full_example_description.length)}\r\n")
    #puts full_example_description
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
    #load "#{Rails.root}/db/seeds.rb"

    # create admin user, so there is a user available
    user_details = {user_name: 'admin', display_name: 'Administrator', email: 'example+admin@example.com', password: 'admin_password', admin: true}
    db_user = User.where(:user_name => user_details[:user_name]).first
    if db_user.blank?
      db_user = User.create(user_details)
      db_user.creator_id = db_user.id
      db_user.updater_id = db_user.id

      db_user.skip_user_name_exclusion_list = true
      db_user.save!
      db_user.skip_user_name_exclusion_list = false
    end
    # finished creating admin user
  end

  config.before(:each, :type => :controller) do
    #controller.use_rails_error_handling!
    #controller.rescue_action_in_public!
    sign_in :user, User.first
  end

  config.after(:all, :type => :controller) do
    Rack::MockRequest::DEFAULT_ENV['devise.mapping']= Devise.mappings[:user]
  end

end


