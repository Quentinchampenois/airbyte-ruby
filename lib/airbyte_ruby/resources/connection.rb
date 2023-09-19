# frozen_string_literal: true

module AirbyteRuby
  module Resources
    # Resource class for Airbyte Connections
    class Connection < Base
      ENDPOINTS = OpenStruct.new(
        list: "/v1/connections?includeDeleted=false&limit=20&offset=0",
        create: "/v1/connections",
        get: "/v1/connections/:connection_id",
        update: "/v1/connections/:connection_id",
        delete: "/v1/connections/:connection_id"
      )

      attr_reader :id, :name, :source_id, :destination_id, :workspace_id

      # TODO: Include Base module once ready
      # rubocop:disable Lint/MissingSuper
      def initialize(args = {})
        @id = args[:id]
        @name = args[:name]
        @workspace_id = args[:workspace_id]
        @source_id = args[:source_id]
        @destination_id = args[:destination_id]
      end
      # rubocop:enable Lint/MissingSuper

      def to_json(*_args)
        {
          name: @name,
          sourceId: @source_id,
          destinationId: @destination_id
        }.to_json
      end

      def fetch_all
        list(ENDPOINTS.list)
      end

      def new
        create(ENDPOINTS.create)
      end

      def fetch
        url = replace_variable_in_url(ENDPOINTS.get, "connection_id")
        get(url)
      end

      def update
        url = replace_variable_in_url(ENDPOINTS.update, "connection_id")
        patch(url)
      end

      def remove
        url = replace_variable_in_url(ENDPOINTS.delete, "connection_id")
        delete(url)
      end
    end
  end
end
