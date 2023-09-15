module AirbyteRuby
  module Requests
    ENDPOINT = "http://localhost:8006/"
    BASIC_AUTH_CREDENTIALS = OpenStruct.new(username: "airbyte", password: "password")

    def list_all
      conn = ::Faraday.new(url: "http://localhost:8006/") do |faraday|
        faraday.set_basic_auth(BASIC_AUTH_CREDENTIALS.username, BASIC_AUTH_CREDENTIALS.password)
      end
      res = conn.get(self.class::LIST_URL)
      JSON.parse(res.body)["data"]
    end
  end
end