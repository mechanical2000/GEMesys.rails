require "rails_helper"

describe Agilibox::PaginationHelper do
  it "should return default theme" do
    expect(described_class.theme).to eq "twitter-bootstrap-3"
  end

  it "should save custom theme" do
    described_class.theme = "bootstrap4"
    expect(described_class.theme).to eq "bootstrap4"
  end
end
