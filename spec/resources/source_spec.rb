# frozen_string_literal: true

RSpec.describe AirbyteRuby::Resources::Source do
  subject { described_class.new(adapter, args) }

  let(:name) { "Airbyte source" }
  let(:id) { "9afc4250-e463-4439-80bd-c9b41b215839" }
  let(:source_type) { "postgres" }
  let(:workspace_id) { "9af17e85-925f-4af3-b06e-55597ac7aff1" }
  let(:adapter) { build(:postgres_adapter) }

  let(:args) do
    {
      name: name,
      id: id,
      source_type: source_type,
      workspace_id: workspace_id
    }
  end

  it "is a instance of Base" do
    expect(subject).to be_a AirbyteRuby::Resources::Base
  end

  it "creates a new instance of Source" do
    expect(subject).to be_a(AirbyteRuby::Resources::Source)
  end

  it "has a name attribute" do
    expect(subject).to respond_to(:name)
    expect(subject.name).to eq("Airbyte source")
  end

  it "has a source_type attribute" do
    expect(subject).to respond_to(:source_type)
    expect(subject.source_type).to eq("postgres")
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

    it "returns a json object" do
      expect(subject.to_json).to be_a(String)
      expect(subject.to_json).to eq(
        {
          name: "Airbyte source",
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
            sourceType: "postgres"
          }
        }.to_json
      )
    end
  end

  describe "#fetch_all" do
    it "responds to method fetch_all" do
      expect(subject).to respond_to(:fetch_all)
    end

    it "returns a list of sources" do
      VCR.use_cassette("resources/source/fetch_all") do
        response = subject.fetch_all
        expect(response).to be_a Faraday::Response
        body = JSON.parse(response.body)["data"]
        expect(body).to be_a(Array)
        expect(body.first).to be_a(Hash)
      end
    end
  end

  describe "#new" do
    it "responds to method new" do
      expect(subject).to respond_to(:new)
    end

    it "creates a new source" do
      VCR.use_cassette("resources/source/new") do
        response = subject.new

        expect(response).to be_a(Faraday::Response)
        body = JSON.parse(response.body)
        expect(body).to include("sourceId")
        expect(body).to include("name")
        expect(body).to include("sourceType")
        expect(body).to include("workspaceId")
        expect(body).to include("configuration")
        expect(body["configuration"]).to be_a(Hash)
      end
    end
  end

  describe "#fetch" do
    it "responds to method fetch" do
      expect(subject).to respond_to(:fetch)
    end

    it "fetches a source" do
      VCR.use_cassette("resources/source/fetch") do
        response = subject.fetch

        expect(response).to be_a(Faraday::Response)
        body = JSON.parse(response.body)
        expect(body).to include("sourceId")
        expect(body).to include("name")
        expect(body).to include("sourceType")
        expect(body).to include("workspaceId")
        expect(body).to include("configuration")
        expect(body["configuration"]).to be_a(Hash)
      end
    end
  end

  describe "#update" do
    let(:id) { "a995c161-42c6-47a7-971b-12366d90bfc5" }
    let(:name) { "Updated name" }

    it "responds to method update" do
      expect(subject).to respond_to(:update)
    end

    it "updates a source" do
      VCR.use_cassette("resources/source/update") do
        response = subject.update

        expect(response).to be_a(Faraday::Response)
        body = JSON.parse(response.body)
        expect(body).to be_a(Hash)
        expect(body).to include("name")
        expect(body["name"]).to eq("Updated name")
      end
    end
  end

  describe "#remove" do
    it "responds to method remove" do
      expect(subject).to respond_to(:remove)
    end

    it "deletes a source" do
      VCR.use_cassette("resources/source/remove") do
        response = subject.remove

        expect(response.status).to eq(204)
      end
    end
  end
end
