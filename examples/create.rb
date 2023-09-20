#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "airbyte_ruby"

db_host = ENV["DB_HOST"] || "localhost"
db_port = ENV["DB_PORT"]&.to_i || 5432
db_name = ENV["DB_NAME"] || "postgres"
db_username = ENV["DB_USERNAME"] || "postgres"
db_password = ENV["DB_PASSWORD"] || ""
workspace_uuid = ENV["WORKSPACE_UUID"]

postgres_adapter = AirbyteRuby::Adapters::Postgres.new(
  host: db_host,
  port: db_port,
  database: db_name,
  username: db_username,
  password: db_password,
  schema: "public",
  ssl_mode: { mode: "prefer" },
  replication_method: { method: "Xmin" },
  tunnel_method: { tunnel_method: "NO_TUNNEL" }
)

source = AirbyteRuby::Resources::Source.new(
  postgres_adapter,
  name: "Airbyte new source",
  workspace_id: workspace_uuid
)

res = source.new

if res.success?
  params = JSON.parse(res.body)
  puts "
  Source successfully created!

  Action : Create
  Airbyte response : #{res.status}
  Source UUID: #{params["sourceId"]}
  Source Name: #{params["name"]}

  See more on http://localhost:8000/workspaces/#{workspace_uuid}/source/#{params["sourceId"]}
"
else
  puts "Something went wrong"
end


destination = AirbyteRuby::Resources::Destination.new(
  postgres_adapter,
  name: "Airbyte new source",
  workspace_id: workspace_uuid
)

res = destination.new

if res.success?
  params = JSON.parse(res.body)
  puts "
------------------------------------

  Destination successfully created!
  Action : Create
  Airbyte response : #{res.status}
  Destination UUID: #{params["destinationId"]}
  Destination Name: #{params["name"]}

  See more on http://localhost:8000/workspaces/#{workspace_uuid}/destination/#{params["destinationId"]}
"
else
  puts "Something went wrong"
end

