require "rails_helper"

class DummySorter < Agilibox::Sorter
  def sort
    case column
    when :string_field
      {column => direction}
    end
  end
end

RSpec.describe Agilibox::Sorter do
  let!(:first) { DummyModel.create!(string_field: "abc") }
  let!(:last)  { DummyModel.create!(string_field: "xyz") }

  it "should sort asc" do
    sorted = DummySorter.(DummyModel.all, "string_field")
    expect(sorted).to eq [first, last]
  end

  it "should sort desc" do
    sorted = DummySorter.(DummyModel.all, "-string_field")
    expect(sorted).to eq [last, first]
  end
end
