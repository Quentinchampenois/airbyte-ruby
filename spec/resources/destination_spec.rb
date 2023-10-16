# frozen_string_literal: true

RSpec.describe AirbyteRuby::Resources::Destination do
  subject { described_class.new(adapter, args) }

  let(:name) { "Airbyte destination" }
  let(:id) { "dbb5da19-01d8-4467-ab94-04de8a137ad6" }
  let(:workspace_id) { "9af17e85-925f-4af3-b06e-55597ac7aff1" }
  let(:adapter) { build(:postgres_adapter) }

  let(:args) do
    {
      name: name,
      id: id,
      workspace_id: workspace_id
    }
  end

  it "is a instance of Base" do
    expect(subject).to be_a AirbyteRuby::Resources::Base
  end

  it "creates a new instance of Destination" do
    expect(subject).to be_a(AirbyteRuby::Resources::Destination)
  end

  it "has a name attribute" do
    expect(subject).to respond_to(:name)
    expect(subject.name).to eq("Airbyte destination")
  end

  it "has a type attribute" do
    expect(subject).to respond_to(:type)
    expect(subject.type).to eq("postgres")
  end

  it "has a workspace_id attribute" do
    expect(subject).to respond_to(:workspace_id)
    expect(subject.workspace_id).to eq("9af17e85-925f-4af3-b06e-55597ac7aff1")
  end

  it "has a connection_configuration attribute" do
    expect(subject).to respond_to(:connection_configuration)
    expect(subject.connection_configuration).to be_a Hash

    expect(subject.connection_configuration).to include(host: "localhost")
    expect(subject.connection_configuration).to include(port: 5432)
    expect(subject.connection_configuration).to include(database: "airbyte")
    expect(subject.connection_configuration).to include(username: "airbyte")
    expect(subject.connection_configuration).to include(password: "airbyte")
    expect(subject.connection_configuration).to include(ssl_mode: { mode: "prefer" })
    expect(subject.connection_configuration).to include(replication_method: { method: "Xmin" })
    expect(subject.connection_configuration).to include(tunnel_method: { tunnel_method: "NO_TUNNEL" })
  end

  describe "#to_json" do
    it "responds to method to_json" do
      expect(subject).to respond_to(:to_json)
    end

    it "returns a json string" do
      expect(subject.to_json).to be_a(String)
      expect(subject.to_json).to eq(
        {
          name: "Airbyte destination",
          workspaceId: "9af17e85-925f-4af3-b06e-55597ac7aff1",
          configuration: {
            host: "localhost",
            port: 5432,
            database: "airbyte",
            schema: "public",
            username: "airbyte",
            password: "airbyte",
            ssl_mode: { mode: "prefer" },
            replication_method: { method: "Xmin" },
            tunnel_method: { tunnel_method: "NO_TUNNEL" },
            destinationType: "postgres"
          }
        }.to_json
      )
    end
  end

  describe "#fetch_all" do
    it "responds to method fetch_all" do
      expect(subject).to respond_to(:fetch_all)
    end

    it "returns a list of destinations" do
      VCR.use_cassette("resources/destination/fetch_all") do
        response = subject.fetch_all

        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body["data"]).to be_a(Array)
        expect(body["data"].first).to be_a(Hash)
        expect(body["data"].first["name"]).to eq("New Airbyte destination")
        expect(body["data"].first["destinationId"]).to eq("dbb5da19-01d8-4467-ab94-04de8a137ad6")
      end
    end
  end

  describe "#new" do
    it "responds to method new" do
      expect(subject).to respond_to(:new)
    end

    it "creates a new destination" do
      VCR.use_cassette("resources/destination/new") do
        response = subject.new

        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body["name"]).to eq("Airbyte destination")
        expect(body["destinationId"]).to eq("fa992347-110c-47b3-9266-0d0b3de90dba")
      end
    end
  end

  describe "#fetch" do
    it "responds to method fetch" do
      expect(subject).to respond_to(:fetch)
    end

    it "fetches a destination" do
      VCR.use_cassette("resources/destination/fetch") do
        response = subject.fetch

        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body["name"]).to eq("New Airbyte destination")
        expect(body["destinationId"]).to eq("dbb5da19-01d8-4467-ab94-04de8a137ad6")
      end
    end
  end

  describe "#update" do
    let(:name) { "Updated name" }

    it "responds to method update" do
      expect(subject).to respond_to(:update)
    end

    it "updates a destination" do
      VCR.use_cassette("resources/destination/update") do
        response = subject.update

        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body["name"]).to eq("Updated name")
        expect(body["destinationId"]).to eq("dbb5da19-01d8-4467-ab94-04de8a137ad6")
      end
    end
  end

  describe "#remove" do
    it "responds to method remove" do
      expect(subject).to respond_to(:remove)
    end

    it "deletes a destination" do
      VCR.use_cassette("resources/destination/remove") do
        response = subject.remove

        expect(response.status).to eq(204)
      end
    end
  end
end
