require "rails_helper"

describe Agilibox::SMS::Strategies::AmazonSNS do
  xit "should send you a SMS" do
    to   = ENV["TEST_SMS_PHONE_NUMBER"]
    body = "This is a test SMS from RSpec"
    described_class.new(to: to, body: body).deliver_now
  end
end
