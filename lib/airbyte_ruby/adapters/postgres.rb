# frozen_string_literal: true

module AirbyteRuby
  module Adapters
    # Postgres type adapter for AirbyteRuby configuration
    class Postgres
      TYPE = :postgres

      attr_accessor :type, :host, :port, :database, :username, :password, :ssl_mode, :replication_method,
                    :tunnel_method

      def initialize(args = {})
        @type = TYPE.to_s
        @host = args[:host]
        @port = args[:port]
        @database = args[:database]
        @schema = args[:schema] || "public"
        @username = args[:username]
        @password = args[:password]
        @ssl_mode = args[:ssl_mode]
        @replication_method = args[:replication_method]
        @tunnel_method = args[:tunnel_method]
      end

      def configuration
        {
          host: @host,
          port: @port,
          database: @database,
          schema: @schema,
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
