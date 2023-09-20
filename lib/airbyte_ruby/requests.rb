# frozen_string_literal: true

module AirbyteRuby
  # Requests module for AirbyteRuby
  module Requests
    ENDPOINT = "http://localhost:8006/"
    BASIC_AUTH_CREDENTIALS = OpenStruct.new(username: "airbyte", password: "password")

    private

    def list(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      conn.get(url)
    end

    def create(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
        faraday.headers["Content-Type"] = "application/json"
      end
      conn.post(url, to_json)
    end

    def get(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      conn.get(url)
    end

    def patch(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
        faraday.headers["Content-Type"] = "application/json"
      end
      conn.patch(url, to_json)
    end

    def delete(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      conn.delete(url)
    end
  end
end
