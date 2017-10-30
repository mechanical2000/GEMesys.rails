require "rails_helper"

class DummyModelSerializer < Agilibox::MiniModelSerializer::Serializer
  def attributes
    [:string_field]
  end

  def fake_field
    "fake_val"
  end
end # class DummyModelSerializer

describe Agilibox::MiniModelSerializer::Serialize do
  let!(:dummy) {
    DummyModel.create!(string_field: "str")
  }

  it "should serialize objects using associated serializer" do
    result = described_class.call(dummy)
    expect(result).to eq("string_field" => "str")
  end

  it "should serialize objects inside array" do
    result = described_class.call([dummy])
    expect(result).to eq(["string_field" => "str"])
  end

  it "should serialize objects inside hash" do
    result = described_class.call(dummy: dummy)
    expect(result).to eq("dummy" => {"string_field" => "str"})
  end

  it "should work on any number of level" do
    result = described_class.call(dummy: {nested: [dummy]})
    expect(result).to eq("dummy" => {"nested" => ["string_field" => "str"]})
  end

  it "should work with ActiveRecord collections" do
    result = described_class.call(DummyModel.all)
    expect(result).to eq ["string_field" => "str"]
  end

  it "should work with method defined in serializer" do
    allow_any_instance_of(DummyModelSerializer).to receive(:attributes).and_return([:fake_field])
    result = described_class.call(dummy)
    expect(result).to eq("fake_field" => "fake_val")
  end

  it "should return serializer method over object method" do
    serializer = DummyModelSerializer.new(dummy)
    def serializer.string_field
      "overrided_val"
    end
    result = serializer.call
    expect(result).to eq("string_field" => "overrided_val")
  end

  it "should work with active record relations" do
    allow_any_instance_of(DummyModelSerializer).to receive(:attributes)
      .and_return([:string_field, :asso])

    other = DummyModel.create!(string_field: "other")
    dummy.update!(asso: other)

    result = described_class.call(dummy)
    expect(result).to eq(
      "string_field" => "str",
      "asso"         => {
        "string_field" => "other",
        "asso"         => nil,
      },
    )
  end

  it "should call #as_json on other objects" do
    str = "a string"
    expect(str).to receive(:as_json).and_call_original
    result = described_class.call(str)
    expect(result).to eq "a string"
  end

  it "should pass options to other serialiers" do
    expect(DummyModelSerializer).to receive(:new)
      .with(dummy, opt: "value")
      .and_call_original

    h = {dummy: {nested: [dummy]}}
    described_class.call(h, opt: "value")
  end
end
