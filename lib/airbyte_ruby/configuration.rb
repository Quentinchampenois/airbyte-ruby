# frozen_string_literal: true

module AirbyteRuby
  # Configuration class for AirbyteRuby
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :airbyte_api_version do
      ENV.fetch("AIRBYTE_API_VERSION", "v1")
    end

    # The endpoint that Airbyte is running on
    # /!\ Must include the trailing slash
    # Defaults to http://localhost:8006/
    # @return [String]
    config_accessor :endpoint do
      endpoint = ENV.fetch("AIRBYTE_ENDPOINT", "http://localhost:8006/")
      endpoint += "/" if endpoint[-1] != "/"

      endpoint
    end

    config_accessor :basic_auth do
      ENV.fetch("AIRBYTE_BASIC_AUTH", "false") == "true"
    end

    config_accessor :airbyte_username do
      ENV.fetch("AIRBYTE_USERNAME", "airbyte")
    end

    config_accessor :airbyte_password do
      ENV.fetch("AIRBYTE_PASSWORD", "password")
    end
  end
end
