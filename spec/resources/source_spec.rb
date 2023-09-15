RSpec.describe AirbyteRuby::Resources::Source do
  subject { described_class.new(args) }

  let(:name) { "Airbyte source" }
  let(:source_type) { "postgres" }
  let(:workspace_id) { "123456789" }
  let(:connection_configuration) do
    {
      "host": "localhost",
      "port": 5432,
      "database": "airbyte",
      "username": "airbyte",
      "password": "airbyte",
      "ssl_mode": {
        "mode": "prefer"
      },
      "replication_method": {
        "method": "Xmin"
      },
      "tunnel_method": {
        "tunnel_method": "NO_TUNNEL"
      }
    }
  end

  let(:args) do
    {
      name: name,
      source_type: source_type,
      workspace_id: workspace_id,
      connection_configuration: connection_configuration
    }
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
    expect(subject.workspace_id).to eq("123456789")
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

  describe "#list" do
    it "returns a list of sources" do
      VCR.use_cassette("resources/source/list") do
        response = subject.list
        expect(response).to be_a(Array)
        expect(response.first).to be_a(Hash)
      end
    end
  end
end