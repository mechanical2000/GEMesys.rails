require "rails_helper"

describe Agilibox::SMS::Strategies::AmazonSNS do
  after do
    described_class.sns_region            = nil
    described_class.sns_access_key_id     = nil
    described_class.sns_secret_access_key = nil
  end

  it "should be configurable" do
    described_class.sns_region            = "a"
    described_class.sns_access_key_id     = "b"
    described_class.sns_secret_access_key = "c"

    expect(described_class.sns_region).to            eq "a"
    expect(described_class.sns_access_key_id).to     eq "b"
    expect(described_class.sns_secret_access_key).to eq "c"
  end

  xit "should send you a SMS" do
    to   = ENV["TEST_SMS_PHONE_NUMBER"]
    body = "This is a test SMS from RSpec"
    described_class.new(to: to, body: body).deliver_now
  end
end
