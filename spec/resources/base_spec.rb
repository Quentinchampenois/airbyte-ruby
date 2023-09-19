RSpec.describe AirbyteRuby::Resources::Base do
  subject { described_class }

  describe "#to_json" do
    it "raises an NotImplementedError" do
      expect { subject.new.to_json }.to raise_error(NotImplementedError)
    end
  end

  describe "#get_all" do
    it "raises an NotImplementedError" do
      expect { subject.new.get_all }.to raise_error(NotImplementedError)
    end
  end

  describe "#new" do
    it "raises an NotImplementedError" do
      expect { subject.new.new }.to raise_error(NotImplementedError)
    end
  end
end