# frozen_string_literal: true

module AirbyteRuby
  module Resources
    # Resource class for Airbyte Sources
    class Source < Base
      ENDPOINTS = OpenStruct.new(
        list: "/sources?includeDeleted=false&limit=20&offset=0",
        create: "/sources",
        get: "/sources/:source_id",
        update: "/sources/:source_id",
        delete: "/sources/:source_id"
      )

      attr_reader :id, :name, :source_type, :workspace_id, :connection_configuration

      # TODO: Include Base module once ready
      # rubocop:disable Lint/MissingSuper
      def initialize(adapter, args = {})
        @id = args[:id]
        @name = args[:name]
        @workspace_id = args[:workspace_id]
        @connection_configuration = adapter.configuration
        @source_type = adapter.type
      end
      # rubocop:enable Lint/MissingSuper

      def to_json(*_args)
        {
          name: @name,
          workspaceId: @workspace_id,
          configuration: @connection_configuration.merge(sourceType: @source_type)
        }.to_json
      end

      def fetch_all
        list(ENDPOINTS.list)
      end

      def new
        create(ENDPOINTS.create)
      end

      def fetch
        url = replace_variable_in_url(ENDPOINTS.get, "source_id")
        get(url)
      end

      def update
        url = replace_variable_in_url(ENDPOINTS.update, "source_id")
        patch(url)
      end

      def remove
        url = replace_variable_in_url(ENDPOINTS.delete, "source_id")
        delete(url)
      end
    end
  end
end
