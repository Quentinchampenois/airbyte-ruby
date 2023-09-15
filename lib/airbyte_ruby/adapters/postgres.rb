module AirbyteRuby
  module Adapters
    class Postgres
      SOURCE_TYPE = :postgres
      attr_reader :source_type, :host, :port, :database, :username, :password, :ssl_mode, :replication_method, :tunnel_method

      def initialize(args={})
        @source_type = SOURCE_TYPE.to_s
        @host = args[:host]
        @port = args[:port]
        @database = args[:database]
        @username = args[:username]
        @password = args[:password]
        @ssl_mode = args[:ssl_mode]
        @replication_method = args[:replication_method]
        @tunnel_method = args[:tunnel_method]
      end
    end
  end
end