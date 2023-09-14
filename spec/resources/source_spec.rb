RSpec.describe AirbyteRuby::Resources::Source do
  subject { described_class.new(args) }

  let(:name) { "Airbyte source" }
  let(:source_type) { "postgres" }
  let(:workspace_id) { "123456789" }
  let(:connection_configuration) { { "host": "localhost", "port": 5432, "database": "airbyte", "username": "airbyte", "password": "airbyte" } }
  let(:args) do
    { name: name, source_type: source_type, workspace_id: workspace_id, connection_configuration: connection_configuration }
  end

  it "creates a new instance of Source" do
    expect(subject).to be_a(AirbyteRuby::Resources::Source)
  end

  it "has a name attribute" do
    expect(subject).to respond_to(:name)
    expect(subject.name).to eq("Airbyte source")
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