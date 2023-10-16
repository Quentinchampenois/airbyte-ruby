# frozen_string_literal: true

require "byebug"
module AirbyteRuby
  # Requests module for AirbyteRuby
  module Requests
    private

    def list(url)
      url = "#{AirbyteRuby::Configuration.airbyte_api_version}#{url}"
      base_conn.get(url)
    end

    def create(url)
      url = "#{AirbyteRuby::Configuration.airbyte_api_version}#{url}"
      base_conn.post(url, to_json)
    end

    def get(url)
      url = "#{AirbyteRuby::Configuration.airbyte_api_version}#{url}"
      base_conn.get(url)
    end

    def patch(url)
      url = "#{AirbyteRuby::Configuration.airbyte_api_version}#{url}"
      base_conn.patch(url, to_json)
    end

    def delete(url)
      url = "#{AirbyteRuby::Configuration.airbyte_api_version}#{url}"
      base_conn.delete(url)
    end

    def base_conn
      endpoint = AirbyteRuby::Configuration.endpoint
      endpoint += "/" if endpoint[-1] != "/"
      ::Faraday.new(url: endpoint) do |faraday|
        if AirbyteRuby::Configuration.basic_auth
          faraday.set_basic_auth(AirbyteRuby::Configuration.airbyte_username,
                                 AirbyteRuby::Configuration.airbyte_password)
        end
        faraday.headers["Content-Type"] = "application/json"
      end
    end
  end
end
