# frozen_string_literal: true

module AirbyteRuby
  module Resources
    class Source
      include AirbyteRuby::Requests

      attr_reader :source_id, :name, :source_type, :workspace_id, :connection_configuration
      LIST_URL = "/v1/sources?includeDeleted=false&limit=20&offset=0"

      def initialize(adapter, args = {})
        @source_id = args[:source_id]
        @name = args[:name]
        @source_type = args[:source_type]
        @workspace_id = args[:workspace_id]
        @connection_configuration = adapter.configuration
      end
    end
  end
end
