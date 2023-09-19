# frozen_string_literal: true

RSpec.describe AirbyteRuby::Resources::Base do
  subject { described_class.new }

  describe "#to_json" do
    it "raises an NotImplementedError" do
      expect { subject.to_json }.to raise_error(NotImplementedError)
    end
  end

  describe "#fetch_all" do
    it "raises an NotImplementedError" do
      expect { subject.fetch_all }.to raise_error(NotImplementedError)
    end
  end

  describe "#new" do
    it "raises an NotImplementedError" do
      expect { subject.new }.to raise_error(NotImplementedError)
    end
  end

  describe "#get" do
    it "raises an NotImplementedError" do
      expect { subject.fetch }.to raise_error(NotImplementedError)
    end
  end

  describe "#remove" do
    it "raises an NotImplementedError" do
      expect { subject.remove }.to raise_error(NotImplementedError)
    end
  end
end
