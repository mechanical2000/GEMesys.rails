require "rails_helper"

describe Agilibox::PluckToHash do
  before do
    DummyModel.create!(string_field: "abc", integer_field: 123)
    DummyModel.create!(string_field: "def", integer_field: 456)
  end

  it "should return hash" do
    hash = DummyModel.reorder(:id).pluck_to_hash(:string_field, :integer_field)

    expect(hash).to eq [
      {string_field: "abc", integer_field: 123},
      {string_field: "def", integer_field: 456},
    ]
  end
end
