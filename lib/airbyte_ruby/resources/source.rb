module AirbyteRuby
  module Resources
    class Source
      attr_reader :source_id, :name, :source_type, :workspace_id, :connection_configuration

      def initialize(args={})
        @source_id = args[:source_id]
        @name = args[:name]
        @source_type = args[:source_type]
        @workspace_id = args[:workspace_id]
        @connection_configuration = args[:connection_configuration]
      end

      def list
        conn = ::Faraday.new(url: 'http://localhost:8006/v1') do |faraday|
          faraday.set_basic_auth('airbyte', 'password')
        end
        response = conn.get('/sources?includeDeleted=false&limit=20&offset=0')

        JSON.parse(response.body)["data"]
      end
    end
  end
end
