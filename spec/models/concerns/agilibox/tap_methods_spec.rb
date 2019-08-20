require "rails_helper"

describe Agilibox::TapMethods do
  let!(:instance) { DummyModel.create! }

  it "#tap_save! without options" do
    expect(instance).to receive(:save!).with({}).and_call_original
    result = instance.tap_save!
    expect(result).to eq instance
  end

  it "#tap_save! with options" do
    expect(instance).to receive(:save!).with(validate: false).and_call_original
    result = instance.tap_save!(validate: false)
    expect(result).to eq instance
  end

  it "#tap_update! with attributes" do
    expect(instance).to receive(:update!).with(string_field: "val").and_call_original
    result = instance.tap_update!(string_field: "val")
    expect(result).to eq instance
  end

  it "#tap_validate without context" do
    expect(instance).to receive(:validate).with(nil).and_call_original
    result = instance.tap_validate
    expect(result).to eq instance
  end

  it "#tap_validate with context" do
    expect(instance).to receive(:validate).with(:context).and_call_original
    result = instance.tap_validate(:context)
    expect(result).to eq instance
  end

  it "#tap_validate! without context" do
    expect(instance).to receive(:validate!).with(nil).and_call_original
    result = instance.tap_validate!
    expect(result).to eq instance
  end

  it "#tap_validate! with context" do
    expect(instance).to receive(:validate!).with(:context).and_call_original
    result = instance.tap_validate!(:context)
    expect(result).to eq instance
  end
end
