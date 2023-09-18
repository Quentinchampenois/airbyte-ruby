# frozen_string_literal: true

RSpec.describe AirbyteRuby::Adapters::Postgres do
  subject { described_class.new(args) }

  let(:args) do
    {
      host: "localhost",
      port: 5432,
      database: "airbyte",
      username: "airbyte",
      password: "airbyte",
      ssl_mode: {
        "mode": "prefer"
      },
      replication_method: {
        "method": "Xmin"
      },
      tunnel_method: {
        "tunnel_method": "NO_TUNNEL"
      }
    }
  end

  it "creates a new instance of Postgres" do
    expect(subject).to be_a(AirbyteRuby::Adapters::Postgres)
  end

  it "has a source_type attribute" do
    expect(subject).to respond_to(:source_type)
    expect(subject.source_type).to eq("postgres")
  end

  it "has a host attribute" do
    expect(subject).to respond_to(:host)
    expect(subject.host).to eq("localhost")
  end

  it "has a port attribute" do
    expect(subject).to respond_to(:port)
    expect(subject.port).to eq(5432)
  end

  it "has a database attribute" do
    expect(subject).to respond_to(:database)
    expect(subject.database).to eq("airbyte")
  end

  it "has a username attribute" do
    expect(subject).to respond_to(:username)
    expect(subject.username).to eq("airbyte")
  end

  it "has a password attribute" do
    expect(subject).to respond_to(:password)
    expect(subject.password).to eq("airbyte")
  end

  it "has a ssl_mode attribute" do
    expect(subject).to respond_to(:ssl_mode)
    expect(subject.ssl_mode).to be_a Hash
    expect(subject.ssl_mode).to include(mode: "prefer")
  end

  it "has a replication_method attribute" do
    expect(subject).to respond_to(:replication_method)
    expect(subject.replication_method).to be_a Hash
    expect(subject.replication_method).to include(method: "Xmin")
  end

  it "has a tunnel_method attribute" do
    expect(subject).to respond_to(:tunnel_method)
    expect(subject.tunnel_method).to be_a Hash
    expect(subject.tunnel_method).to include(tunnel_method: "NO_TUNNEL")
  end

  context "when no args are passed" do
    subject { described_class.new }

    it "creates a new instance of Postgres" do
      expect(subject).to be_a(AirbyteRuby::Adapters::Postgres)
    end
  end

  describe "#configuration" do
    it "returns a hash with the correct attributes" do
      configuration = subject.configuration
      expect(configuration).to be_a Hash
      expect(configuration).to include(sourceType: "postgres")
      expect(configuration).to include(host: "localhost")
      expect(configuration).to include(port: 5432)
      expect(configuration).to include(database: "airbyte")
      expect(configuration).to include(username: "airbyte")
      expect(configuration).to include(password: "airbyte")
      expect(configuration).to include(ssl_mode: { mode: "prefer" })
      expect(configuration).to include(replication_method: { method: "Xmin" })
      expect(configuration).to include(tunnel_method: { tunnel_method: "NO_TUNNEL" })
    end
  end
end
