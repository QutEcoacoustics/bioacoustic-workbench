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
end