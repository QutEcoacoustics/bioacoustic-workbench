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

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # mixin core methods
  config.include FactoryGirl::Syntax::Methods
end


require 'net/http'
require 'json'

require 'simplecov'
SimpleCov.start

require 'database_cleaner'

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


# support for running seed data with tests
load "#{Rails.root}/db/seeds.rb"

# https://github.com/bmabey/database_cleaner
# http://stackoverflow.com/a/5964483
# http://stackoverflow.com/a/9248602
# I found the SQLite exception solution was to remove the clean_with(:truncation) and change the strategy entirely to DatabaseCleaner.strategy = :truncation
DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # setup and tear down
  setup    :setup_database
  teardown :clean_database

  # user for tests - user name is from development_seeds.rb
  @user = User.where(:display_name => 'A normal user').first!

  # Add more helper methods to be used by all tests here...
  def get_source_audio_file_path(file_name)
    input_path = './test/fixtures/audio'
    File.join input_path, file_name
  end

  def get_target_file_path(file_name)
    output_path = './tmp/testassests'
    File.join output_path, file_name
  end

  def delete_if_exists(file_path)
    if File.exists? file_path
      File.delete file_path
    end
  end

  private

  def setup_database
    DatabaseCleaner.start
  end

  def clean_database
    DatabaseCleaner.clean
  end
end

require 'enumerize'

class ActionController::TestCase
  include Devise::TestHelpers

  @current_logged_in_user

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_logged_in_user = get_admin
    sign_in @current_logged_in_user
    @current_logged_in_user.reset_authentication_token!
  end

  def get_admin
    User.where(:user_name => 'admin').first!
  end

  def get_user(user_name)
    User.where(:user_name => user_name).first!
  end

end