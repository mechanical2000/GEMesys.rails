require "rails_helper"

describe Agilibox::ActiveRecordCommaTypeCast, type: :model do
  let(:record) { DummyModel.create! }

  it "should accept , as decimal separator" do
    record.update!(decimal_field: "12,34")
    expect(record.reload.decimal_field).to eq 12.34
  end

  it "should accept . as decimal separator" do
    record.update!(decimal_field: "12.34")
    expect(record.reload.decimal_field).to eq 12.34
  end

  it "should accept space as group separator" do
    record.update!(decimal_field: "123 456,78")
    expect(record.reload.decimal_field).to eq 123_456.78

    record.update!(decimal_field: "123 456.78")
    expect(record.reload.decimal_field).to eq 123_456.78
  end

  it "should accept nbsp as group separator" do
    record.update!(decimal_field: "123 456,78")
    expect(record.reload.decimal_field).to eq 123_456.78

    record.update!(decimal_field: "123 456.78")
    expect(record.reload.decimal_field).to eq 123_456.78
  end

  it "should accept negative numbers" do
    record.update!(decimal_field: "-12,34")
    expect(record.reload.decimal_field).to eq(-12.34)

    record.update!(decimal_field: "-12.34")
    expect(record.reload.decimal_field).to eq(-12.34)
  end

  it "should accept trailing chars" do
    record.update!(decimal_field: "abc 12.34 def")
    expect(record.reload.decimal_field).to eq 12.34
  end
end
