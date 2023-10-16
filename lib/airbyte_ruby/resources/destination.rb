# frozen_string_literal: true

module AirbyteRuby
  module Resources
    # Resource class for Airbyte Destinations
    class Destination < Base
      ENDPOINTS = OpenStruct.new(
        list: "/destinations?includeDeleted=false&limit=20&offset=0",
        create: "/destinations",
        get: "/destinations/:destination_id",
        update: "/destinations/:destination_id",
        delete: "/destinations/:destination_id"
      )

      attr_reader :id, :name, :type, :workspace_id, :connection_configuration

      # TODO: Include Base module once ready
      # rubocop:disable Lint/MissingSuper
      def initialize(adapter, args = {})
        @id = args[:id]
        @name = args[:name]
        @workspace_id = args[:workspace_id]
        @connection_configuration = adapter.configuration
        @type = adapter.type
      end
      # rubocop:enable Lint/MissingSuper

      def to_json(*_args)
        {
          name: @name,
          workspaceId: @workspace_id,
          configuration: @connection_configuration.merge(destinationType: @type)
        }.to_json
      end

      def fetch_all
        list(ENDPOINTS.list)
      end

      def new
        create(ENDPOINTS.create)
      end

      def fetch
        url = replace_variable_in_url(ENDPOINTS.get, "destination_id")
        get(url)
      end

      def update
        url = replace_variable_in_url(ENDPOINTS.update, "destination_id")
        patch(url)
      end

      def remove
        url = replace_variable_in_url(ENDPOINTS.delete, "destination_id")
        delete(url)
      end
    end
  end
end
