# frozen_string_literal: true

module AirbyteRuby
  module Requests
    ENDPOINT = "http://localhost:8006/"
    BASIC_AUTH_CREDENTIALS = OpenStruct.new(username: "airbyte", password: "password")

    private

    def list(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      res = conn.get(url)
      JSON.parse(res.body)["data"]
    end

    def create(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
        faraday.headers["Content-Type"] = "application/json"
      end
      res = conn.post(url, to_json)
      JSON.parse(res.body)
    end

    def get(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      res = conn.get(url)
      JSON.parse(res.body)
    end

    def patch(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
        faraday.headers["Content-Type"] = "application/json"
      end
      res = conn.patch(url, to_json)
      JSON.parse(res.body)
    end

    def delete(url)
      conn = ::Faraday.new(url: ENDPOINT) do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      conn.delete(url)
    end
  end
end
