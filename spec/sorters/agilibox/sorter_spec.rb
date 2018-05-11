require "rails_helper"

describe Agilibox::Sorter do
  let!(:first) { DummyModel.create!(string_field: "abc") }
  let!(:last)  { DummyModel.create!(string_field: "xyz") }

  let(:sorter) {
    Class.new(Agilibox::Sorter) do
      def sort
        case column
        when :string_field
          {column => direction}
        else
          {string_field: :asc}
        end
      end
    end
  }

  it "should sort asc" do
    sorted = sorter.call(DummyModel.all, "string_field")
  end

  it "should sort desc" do
    sorted = sorter.call(DummyModel.all, "-string_field")
    expect(sorted).to eq [last, first]
  end

  it ":sort_param is optionnal to allow default sorting" do
    sorted = sorter.call(DummyModel.all)
    expect(sorted).to eq [first, last]
  end
end
