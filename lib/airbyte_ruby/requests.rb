module AirbyteRuby
  module Requests
    ENDPOINT = "http://localhost:8006/"
    BASIC_AUTH_CREDENTIALS = OpenStruct.new(username: "airbyte", password: "password")

    def list_all
      conn = ::Faraday.new(url: "http://localhost:8006/") do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      res = conn.get(self.class::ENDPOINTS.list)
      JSON.parse(res.body)["data"]
    end

    def create
      conn = ::Faraday.new(url: "http://localhost:8006/") do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
        faraday.headers["Content-Type"] = "application/json"
      end
      res = conn.post(self.class::ENDPOINTS.create, self.to_json)
      JSON.parse(res.body)
    end
  end
end