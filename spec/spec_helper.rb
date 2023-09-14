# frozen_string_literal: true

require "airbyte_ruby"
require "byebug"
require 'vcr'
require 'webmock/rspec'


VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

WebMock.enable!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    WebMock.allow_net_connect!(allow_localhost: false)
  end

  # Disable WebMock after the tests are done.
  config.after(:each) do
    WebMock.disable_net_connect!(allow_localhost: false)
  end
end
