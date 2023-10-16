# frozen_string_literal: true

RSpec.describe AirbyteRuby::Resources::Connection do
  subject { described_class.new(args) }

  let(:name) { "Airbyte connection" }
  let(:id) { "123e4567-e89b-12d3-a456-426614174000" }
  let(:source_id) { "123e4567-e89b-12d3-a456-426614174000" }
  let(:destination_id) { "123e4567-e89b-12d3-a456-426614174000" }
  let(:workspace_id) { "9af17e85-925f-4af3-b06e-55597ac7aff1" }

  let(:args) do
    {
      name: name,
      id: id,
      source_id: source_id,
      destination_id: destination_id,
      workspace_id: workspace_id
    }
  end

  it "is a instance of Base" do
    expect(subject).to be_a AirbyteRuby::Resources::Base
  end

  it "creates a new instance of Connection" do
    expect(subject).to be_a(AirbyteRuby::Resources::Connection)
  end

  it "has a name attribute" do
    expect(subject).to respond_to(:name)
    expect(subject.name).to eq("Airbyte connection")
  end

  it "has a workspace_id attribute" do
    expect(subject).to respond_to(:workspace_id)
    expect(subject.workspace_id).to eq("9af17e85-925f-4af3-b06e-55597ac7aff1")
  end

  describe "#to_json" do
    it "responds to method to_json" do
      expect(subject).to respond_to(:to_json)
    end

    it "returns a json string" do
      expect(subject.to_json).to be_a(String)
      expect(subject.to_json).to eq(
        {
          name: "Airbyte connection",
          sourceId: "123e4567-e89b-12d3-a456-426614174000",
          destinationId: "123e4567-e89b-12d3-a456-426614174000"
        }.to_json
      )
    end
  end

  describe "#fetch_all" do
    it "responds to method fetch_all" do
      expect(subject).to respond_to(:fetch_all)
    end
  end

  describe "#new" do
    it "responds to method new" do
      expect(subject).to respond_to(:new)
    end
  end

  describe "#fetch" do
    it "responds to method fetch" do
      expect(subject).to respond_to(:fetch)
    end
  end

  describe "#update" do
    let(:id) { "123456789-42c6-47a7-971b-12366d90bfc5" }
    let(:name) { "Connection updated name" }

    it "responds to method update" do
      expect(subject).to respond_to(:update)
    end
  end

  describe "#remove" do
    it "responds to method remove" do
      expect(subject).to respond_to(:remove)
    end

    it "deletes a connection" do
      VCR.use_cassette("resources/connection/remove") do
        response = subject.remove

        expect(response.status).to eq(204)
      end
    end
  end
end
