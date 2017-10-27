require "rails_helper"

describe Agilibox::TokenGenerator do
  it "default size should be 64" do
    token = described_class.call
    expect(token.length).to eq 64
  end

  it "should generate using custom size" do
    token = described_class.call(size: 4)
    expect(token.length).to eq 4
  end

  it "should generate using custom alphabet" do
    token = described_class.call(alphabet: [0, 1])
    expect(token).to match(/^[01]+$/)
  end
end
