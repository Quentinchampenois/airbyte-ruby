# frozen_string_literal: true

require "faraday"
require "ostruct"
require "active_support/configurable"
require_relative "airbyte_ruby/version"
require_relative "airbyte_ruby/configuration"
require_relative "airbyte_ruby/requests"
require_relative "airbyte_ruby/resources/base"
require_relative "airbyte_ruby/resources/source"
require_relative "airbyte_ruby/resources/destination"
require_relative "airbyte_ruby/resources/connection"
require_relative "airbyte_ruby/adapters/postgres"

# AirbyteRuby is a Ruby library for the Airbyte API.
module AirbyteRuby
  class Error < StandardError; end
end
