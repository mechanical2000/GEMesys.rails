require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByKeyValues do
  let!(:a) { DummyModel.create!(string_field: "a") }
  let!(:b) { DummyModel.create!(string_field: "b") }
  let!(:c) { DummyModel.create!(string_field: "c") }

  def filter_by(value)
    described_class.new(:string_field).apply(DummyModel.all, value)
  end

  it "should filter single value in a string" do
    results = filter_by("a")
    expect(results).to contain_exactly(a)
  end

  it "should filter multiple value in a string" do
    results = filter_by("a b")
    expect(results).to contain_exactly(a, b)
  end

  it "should filter single value in a array" do
    results = filter_by(["a"])
    expect(results).to contain_exactly(a)
  end

  it "should filter multiple value in a array" do
    results = filter_by(%w(a b))
    expect(results).to contain_exactly(a, b)
  end

  it "should ignore empty values in array" do
    DummyModel.create!(string_field: "")
    DummyModel.create!(string_field: nil)

    results = filter_by(["a", "", nil])
    expect(results).to contain_exactly(a)
  end
end
