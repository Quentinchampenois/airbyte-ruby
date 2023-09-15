# frozen_string_literal: true

require "faraday"
require "ostruct"
require_relative "airbyte_ruby/version"
require_relative 'airbyte_ruby/requests'
require_relative "airbyte_ruby/resources/source"
require_relative "airbyte_ruby/adapters/postgres"

module AirbyteRuby
  class Error < StandardError; end

  def self.api_version
    ENV["AIRBYTE_API_VERSION"] || "v1"
  end
end
