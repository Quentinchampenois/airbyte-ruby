# frozen_string_literal: true

if ENV["CI"]
  require "simplecov"
  require "simplecov-cobertura"
  SimpleCov.start do
    add_filter "/spec/"
    add_filter "/.github/"
    add_filter "/.git/"
    add_filter "/bin/"
    add_filter "/examples/"
    add_filter "/sig/"
  end
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

require "airbyte_ruby"
require "vcr"
require "webmock/rspec"
require "factory_bot"
require "factories"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

WebMock.enable!
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.include FactoryBot::Syntax::Methods

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
