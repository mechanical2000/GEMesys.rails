require "rails_helper"

describe Agilibox::PhoneNumberSanitizer do
  it "should sanitize number" do
    sanitized = described_class.call("Benoit : +33 6 99 88 77 66")
    expect(sanitized).to eq "+33699887766"
  end

  it "return nil if not a number" do
    sanitized = described_class.call("Benoit")
    expect(sanitized).to eq nil
  end
end
