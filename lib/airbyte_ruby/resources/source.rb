# frozen_string_literal: true

module AirbyteRuby
  module Resources
    class Source
      attr_reader :source_id, :name, :source_type, :workspace_id, :connection_configuration

      def initialize(adapter, args = {})
        @source_id = args[:source_id]
        @name = args[:name]
        @source_type = args[:source_type]
        @workspace_id = args[:workspace_id]
        @connection_configuration = adapter.configuration
      end

      def list
        conn = ::Faraday.new(url: "http://localhost:8006/") do |faraday|
          faraday.set_basic_auth("airbyte", "password")
        end
        res = conn.get("/v1/sources?includeDeleted=false&limit=20&offset=0")
        JSON.parse(res.body)["data"]
      end
    end
  end
end
