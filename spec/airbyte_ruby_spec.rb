# frozen_string_literal: true

RSpec.describe AirbyteRuby do
  it "has a version number" do
    expect(AirbyteRuby::VERSION).to eq "0.1.0"
  end

  context "when env var is defined" do
    before do
      allow(ENV).to receive(:[]).with("AIRBYTE_API_VERSION").and_return("v2")
    end

    it "returns the env var value" do
      expect(AirbyteRuby.api_version).to eq "v2"
    end
  end
end
