# frozen_string_literal: true

module AirbyteRuby
  module Resources
    class Source < Base
      ENDPOINTS = OpenStruct.new(
        list: "/v1/sources?includeDeleted=false&limit=20&offset=0",
        create: "/v1/sources"
      )

      attr_reader :source_id, :name, :source_type, :workspace_id, :connection_configuration

      def initialize(adapter, args = {})
        @source_id = args[:source_id]
        @name = args[:name]
        @workspace_id = args[:workspace_id]
        @connection_configuration = adapter.configuration
        @source_type = adapter.source_type
      end

      def to_json
        {
          name: @name,
          workspaceId: @workspace_id,
          configuration: @connection_configuration
        }.to_json
      end

      def get_all
        list(ENDPOINTS.list)
      end

      def new
        create(ENDPOINTS.create)
      end
    end
  end
end
