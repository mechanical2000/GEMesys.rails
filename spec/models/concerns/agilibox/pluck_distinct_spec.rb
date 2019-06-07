require "rails_helper"

describe Agilibox::PluckDistinct do
  before do
    DummyModel.create!(string_field: "b")
    DummyModel.create!(string_field: "a")
    DummyModel.create!(string_field: "b")
  end

  it "should return distinct sorted array" do
    arr = DummyModel.pluck_distinct(:string_field)
    expect(arr).to eq %w(a b)
  end
end
