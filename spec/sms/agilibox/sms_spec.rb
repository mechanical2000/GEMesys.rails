require "rails_helper"

describe Agilibox::SMS do
  after do
    described_class.strategy = nil
    described_class.default_from = nil
  end

  describe "::strategy" do
    it "should return default strategy" do
      expect(described_class.strategy).to eq Agilibox::SMS::Strategies::Test
    end

    it "should set strategy" do
      described_class.strategy = "zzz"
      expect(described_class.strategy).to eq "zzz"
    end

    it "should set strategy from symbol" do
      described_class.strategy = :test
      expect(described_class.strategy).to eq Agilibox::SMS::Strategies::Test
    end
  end # describe "::strategy"

  describe "::default_from" do
    it "should return default value" do
      expect(described_class.default_from).to eq "Dummy"
    end

    it "should set default_from" do
      described_class.default_from = "zzz"
      expect(described_class.default_from).to eq "zzz"
    end
  end # describe "::default_from"
end
