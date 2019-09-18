require "rails_helper"

describe Agilibox::ActiveModelTypeCast, type: :model do
  let(:record) { DummyModel.create! }

  describe "decimals" do
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

    it "still accept decimals" do
      record.update!(decimal_field: 12.34)
      expect(record.reload.decimal_field).to eq 12.34
    end
  end # describe "decimals"

  describe "dates" do
    let!(:date) { Date.new(2012, 12, 21) }

    it "should remove spaces" do
      record.update!(date_field: " 2012 - 12 - 21 ")
      expect(record.reload.date_field).to eq date
    end

    it "should remove spaces" do
      record.update!(date_field: " 21 / 12 / 2012 ")
      expect(record.reload.date_field).to eq date
    end

    it "should not remove space on other formats" do
      record.update!(date_field: " Dec 21 2012 ")
      expect(record.reload.date_field).to eq date
    end

    it "still accept dates" do
      record.update!(date_field: date)
      expect(record.reload.date_field).to eq date
    end
  end # describe "dates"

  describe "booleans" do
    it "should strip true value" do
      record.update!(boolean_field: " t ")
      expect(record.reload.boolean_field).to eq true
    end

    it "should strip false value" do
      record.update!(boolean_field: " f ")
      expect(record.reload.boolean_field).to eq false
    end

    it "should cast blank to nil" do
      record.update!(boolean_field: " ")
      expect(record.reload.boolean_field).to eq nil
    end

    it "still accept true" do
      record.update!(boolean_field: true)
      expect(record.reload.boolean_field).to eq true
    end

    it "still accept false" do
      record.update!(boolean_field: false)
      expect(record.reload.boolean_field).to eq false
    end
  end # describe "booleans"
end
