# frozen_string_literal: true

FactoryBot.define do
  factory :postgres_adapter, class: AirbyteRuby::Adapters::Postgres do
    host { "localhost" }
    port { 5432 }
    database { "airbyte" }
    username { "airbyte" }
    password { "airbyte" }
    ssl_mode { { "mode": "prefer" } }
    replication_method { { "method": "Xmin" } }
    tunnel_method { { "tunnel_method": "NO_TUNNEL" } }
  end
end
