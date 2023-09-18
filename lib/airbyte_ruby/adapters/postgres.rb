# frozen_string_literal: true

module AirbyteRuby
  module Adapters
    class Postgres
      SOURCE_TYPE = :postgres

      attr_accessor :source_type, :host, :port, :database, :username, :password, :ssl_mode, :replication_method,
                    :tunnel_method

      def initialize(args = {})
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

      def configuration
        {
          sourceType: @source_type,
          host: @host,
          port: @port,
          database: @database,
          username: @username,
          password: @password,
          ssl_mode: @ssl_mode,
          replication_method: @replication_method,
          tunnel_method: @tunnel_method
        }
      end
    end
  end
end
