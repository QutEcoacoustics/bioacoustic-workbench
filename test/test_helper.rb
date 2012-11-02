require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# support for running seed data with tests
load "#{Rails.root}/db/seeds.rb"


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

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
end
