require "rails_helper"

describe Agilibox::SmallData::Filter do
  let(:jar)    { {} }
  let(:filter) { {"name" => "bidule"} }
  let(:f)      { Agilibox::SmallData::Filter.new(jar) }

  class TestFilter < Agilibox::SmallData::Filter
    STRATEGIES = {
      "state" => ::Agilibox::SmallData::FilterStrategyByKeyValue.new(:state),
    }
  end

  describe "write" do
    it "should write the provided hash as json in the jar" do
      f.write(filter)
      expect(jar["filters"]).to eq filter.to_json
    end
  end

  describe "read" do
    it "should read stored filters" do
      f.write(filter)
      expect(f.read).to eq(filter)
    end

    it "should return empty hash by default" do
      expect(f.read).to eq({})
    end

    it "should return empty hash on invalid json" do
      jar["filters"] = "i am invalid"
      expect(f.read).to eq({})
    end
  end

  describe "get/set values" do
    let(:filter) { TestFilter.new({}) }

    it "should work" do
      filter.state = "truc"
      expect(filter.state).to eq "truc"
    end

    it "should not work with invalid attributes" do
      expect {
        filter.invalid
      }.to raise_error(NoMethodError)

      expect {
        filter.invalid = "truc"
      }.to raise_error(NoMethodError)
    end

    it "should defined respond_to_missing?" do
      expect(filter.send(:respond_to_missing?, :state)).to be true
      expect(filter.send(:respond_to_missing?, :state=)).to be true
      expect(filter.send(:respond_to_missing?, :invalid)).to be false
      expect(filter.send(:respond_to_missing?, :invalid=)).to be false
    end
  end # describe "get/set values"

  describe "#any? / #empty?" do
    it "should work with value" do
      filter = TestFilter.new("filters" => {state: "value"}.to_json)
      expect(filter.any?).to be true
      expect(filter.empty?).to be false
    end

    it "should work with blank value" do
      filter = TestFilter.new("filters" => {state: ""}.to_json)
      expect(filter.any?).to be false
      expect(filter.empty?).to be true
    end

    it "should work without value" do
      filter = TestFilter.new("filters" => {}.to_json)
      expect(filter.any?).to be false
      expect(filter.empty?).to be true
    end

    it "should ignore other filters strategies" do
      filter = TestFilter.new("filters" => {other: "value"}.to_json)
      expect(filter.any?).to be false
      expect(filter.empty?).to be true
    end
  end # describe "#any? / #empty?"
end
