require 'rails_helper'

describe Agilibox::TextHelper, type: :helper do
  it "hours" do
    expect(hours(nil)).to be nil
    expect(hours(1)).to eq "1,00 heure"
    expect(hours(3)).to eq "3,00 heures"
    expect(hours(3.5)).to eq "3,50 heures"
    expect(hours(3.123)).to eq "3,12 heures"
  end

  it "number" do
    expect(number(nil)).to be nil
    expect(number(1)).to eq "1"
    expect(number(1.2)).to eq "1,20"
    expect(number(1.234)).to eq "1,23"
    expect(number(123456.789)).to eq "123 456,79"
  end

  it "percentage" do
    expect(percentage(nil)).to be nil
    expect(percentage(1)).to eq "1\u00A0%"
    expect(percentage(1.123)).to eq "1,12\u00A0%"
  end

  it "euros" do
    expect(euros(nil)).to be nil
    expect(euros(1)).to eq "1\u00A0€"
    expect(euros(1.123)).to eq "1,12\u00A0€"
  end

  it "date" do
    expect(date(nil)).to be nil
    expect(date(Date.parse("2012-12-21"))).to eq "21/12/2012"
  end

  it "text2html" do
    expect(text2html(nil)).to be nil
    expect(text2html(" \n")).to be nil
    expect(text2html("hello\nworld")).to eq "hello<br />world"
    expect(text2html("hello\r\nworld")).to eq "hello<br />world"
    expect(text2html("\n\nhello\nworld\n\n\n")).to eq "hello<br />world"
    expect(text2html("<b>hello</b> world")).to eq "hello world"
  end

  it "should work with module calls" do
    expect(Agilibox::AllHelpers.number(1.2)).to eq "1,20"
  end

  describe "#info" do
    let(:dummy_instance) {
      l = DummyModel.create!(
        :string_field  => "abc",
        :decimal_field => 1000.17,
      )

      def l.date; Date.parse("2015-01-25"); end
      def l.time; Time.parse("2015-01-25  17:09:23"); end
      def l.paid?; true end
      l
    }

    it "should work with strings" do
      expect(info dummy_instance, :string_field).to eq %(<div class="info"><strong class="info-label">String field</strong><span class="info-separator"> : </span><span class="info-value dummy_model-string_field">abc</span></div>)
    end

    it "should accept other tags" do
      expect(info dummy_instance, :string_field, nil, tag: :p).to eq %(<p class="info"><strong class="info-label">String field</strong><span class="info-separator"> : </span><span class="info-value dummy_model-string_field">abc</span></p>)
    end

    it "should accept custom separator" do
      expect(info dummy_instance, :string_field, separator: "->").to eq %(<div class="info"><strong class="info-label">String field</strong><span class="info-separator">-&gt;</span><span class="info-value dummy_model-string_field">abc</span></div>)
    end

    it "should accept nested values" do
      def dummy_instance.state; "draft"; end
      expect(info dummy_instance, :state).to eq %(<div class="info"><strong class="info-label">État</strong><span class="info-separator"> : </span><span class="info-value dummy_model-state">Brouillon</span></div>)
    end

    it "should override value" do
      expect(info dummy_instance, :string_field, "zzzzz").to include "zzzzz"
    end

    it "should work with floats" do
      expect(info dummy_instance, :decimal_field).to include "1 000,17"
    end

    it "should work with date" do
      expect(info dummy_instance, :date).to include "25/01/2015"
    end

    it "should work with time" do
      expect(info dummy_instance, :time).to include "25/01/2015 à 17:09"
    end

    it "should work with booleans" do
      expect(info dummy_instance, :paid?).to include "Oui"
    end

    it "should accept helper" do
      expect(info dummy_instance, :decimal_field, helper: :euros).to include "1\u00A0000,17\u00A0€"
    end

    it "should work with class" do
      expect(info DummyModel, :integer_field, 123).to eq %(<div class="info"><strong class="info-label">Integer field</strong><span class="info-separator"> : </span><span class="info-value dummy_model-integer_field">123</span></div>)
    end

    it "should accept default value" do
      dummy_instance.string_field = nil
      expect(info dummy_instance, :string_field, default: "hello").to eq %(<div class="info"><strong class="info-label">String field</strong><span class="info-separator"> : </span><span class="info-value dummy_model-string_field">hello</span></div>)
    end

    it "should add blank class" do
      dummy_instance.string_field = nil
      expect(info dummy_instance, :string_field).to eq %(<div class="info blank"><strong class="info-label">String field</strong><span class="info-separator"> : </span><span class="info-value dummy_model-string_field"></span></div>)
    end

    it "should accept :hide as default value" do
      dummy_instance.string_field = nil
      expect(info dummy_instance, :string_field, default: :hide).to eq nil
    end

    it "should hide on blank strings" do
      dummy_instance.string_field = " \n"
      expect(info dummy_instance, :string_field, default: :hide).to eq nil
    end
  end

end
