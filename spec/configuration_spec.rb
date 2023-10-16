# frozen_string_literal: true

RSpec.describe AirbyteRuby::Configuration do
  subject { described_class.new }

  describe "#endpoint" do
    it "has default value" do
      expect(subject.endpoint).to eq("http://localhost:8006/")
    end

    context "when endpoint is set" do
      let(:endpoint) { "http://my.airbyte.endpoint/" }
      before { subject.endpoint = endpoint }

      it "returns the endpoint" do
        expect(subject.endpoint).to eq(endpoint)
      end
    end
  end

  describe "#basic_auth" do
    it "has default value" do
      expect(subject.basic_auth).to be_falsey
    end

    context "when basic_auth is set" do
      before { subject.basic_auth = true }

      it "returns the basic_auth" do
        expect(subject.basic_auth).to be_truthy
      end
    end
  end

  describe "#airbyte_username" do
    it "has default value" do
      expect(subject.airbyte_username).to eq("airbyte")
    end

    context "when airbyte_username is set" do
      let(:airbyte_username) { "myusername" }
      before { subject.airbyte_username = airbyte_username }

      it "returns the airbyte_username" do
        expect(subject.airbyte_username).to eq(airbyte_username)
      end
    end
  end

  describe "#airbyte_password" do
    it "has default value" do
      expect(subject.airbyte_password).to eq("password")
    end

    context "when airbyte_password is set" do
      let(:airbyte_password) { "mypassword" }
      before { subject.airbyte_password = airbyte_password }

      it "returns the airbyte_password" do
        expect(subject.airbyte_password).to eq(airbyte_password)
      end
    end
  end
end
