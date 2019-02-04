require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByKeyValue do
  it "should generate column name key is a symbol" do
    strategy = described_class.new(:string_field)
    query = DummyModel.all
    column = strategy.column_for(query)
    expect(column).to eq "dummy_models.string_field"
  end

  it "should generate column name key is a string_field" do
    strategy = described_class.new("my.column")
    query = DummyModel.all
    column = strategy.column_for(query)
    expect(column).to eq "my.column"
  end

  it "should filter results by value" do
    a = DummyModel.create!(string_field: "a")
    b = DummyModel.create!(string_field: "b")

    results = described_class.new(:string_field).apply(DummyModel.all, "a")
    expect(results).to eq [a]
  end

  it "should filter by true" do
    t = DummyModel.create!(boolean_field: true)
    f = DummyModel.create!(boolean_field: false)

    results = described_class.new(:boolean_field).apply(DummyModel.all, "true")
    expect(results).to eq [t]
  end

  it "should filter by false" do
    t = DummyModel.create!(boolean_field: true)
    f = DummyModel.create!(boolean_field: false)

    results = described_class.new(:boolean_field).apply(DummyModel.all, "false")
    expect(results).to eq [f]
  end

  it "should filter by nil" do
    is_nil = DummyModel.create!(string_field: nil)
    is_not_nil = DummyModel.create!(string_field: "value")

    results = described_class.new(:string_field).apply(DummyModel.all, "nil")
    expect(results).to eq [is_nil]
  end

  it "should filter by null" do
    is_nil = DummyModel.create!(string_field: nil)
    is_not_nil = DummyModel.create!(string_field: "value")

    results = described_class.new(:string_field).apply(DummyModel.all, "null")
    expect(results).to eq [is_nil]
  end

  it "should filter by not_nil" do
    is_nil = DummyModel.create!(string_field: nil)
    is_not_nil = DummyModel.create!(string_field: "value")

    results = described_class.new(:string_field).apply(DummyModel.all, "not_nil")
    expect(results).to eq [is_not_nil]
  end

  it "should filter by not_null" do
    is_nil = DummyModel.create!(string_field: nil)
    is_not_nil = DummyModel.create!(string_field: "value")

    results = described_class.new(:string_field).apply(DummyModel.all, "not_null")
    expect(results).to eq [is_not_nil]
  end
end
