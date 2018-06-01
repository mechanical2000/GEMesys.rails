require "rails_helper"

describe Agilibox::FCM::Request do
  let(:response_ok) {
    {
      :multicast_id  => 123,
      :success       => 1,
      :failure       => 0,
      :canonical_ids => 0,
      :results       => [{:message_id => "xxx"}],
    }
  }

  let(:response_token_expired) {
    {
      :multicast_id  => 123,
      :success       => 0,
      :failure       => 1,
      :canonical_ids => 0,
      :results       => [{:error => "NotRegistered"}],
    }
  }

  let(:response_token_invalid) {
    {
      :multicast_id  => 123,
      :success       => 0,
      :failure       => 1,
      :canonical_ids => 0,
      :results       => [{:error => "InvalidRegistration"}],
    }
  }

  it "#call should return self" do
    fcm = described_class.new({})
    expect(HTTParty).to receive(:post).and_return(OpenStruct.new(body: "{}"))
    expect(fcm.call).to eq fcm
  end

  it "#call should perform HTTP request and parse json" do
    fcm = described_class.new({})
    expect(HTTParty).to receive(:post).and_return(OpenStruct.new(body: {hello: "world"}.to_json))
    fcm.call
    expect(fcm.response_json).to eq(hello: "world")
  end

  it "should parse response_ok" do
    fcm = described_class.new({})
    allow(fcm).to receive(:response_json) { response_ok }
    expect(fcm.ok?).to be true
    expect(fcm.error?).to be false
    expect(fcm.errors).to eq []
    expect(fcm.invalid_token?).to be false
  end

  it "should parse response_token_expired" do
    fcm = described_class.new({})
    allow(fcm).to receive(:response_json) { response_token_expired }
    expect(fcm.ok?).to be false
    expect(fcm.error?).to be true
    expect(fcm.errors).to eq ["NotRegistered"]
    expect(fcm.invalid_token?).to be true
  end

  it "should parse response_token_invalid" do
    fcm = described_class.new({})
    allow(fcm).to receive(:response_json) { response_token_invalid }
    expect(fcm.ok?).to be false
    expect(fcm.error?).to be true
    expect(fcm.errors).to eq ["InvalidRegistration"]
    expect(fcm.invalid_token?).to be true
  end

  it "should parse response in real life", ignore_ci: true do
    fcm = described_class.(to: "i_am_an_invalid_token", data: {})
    expect(fcm.ok?).to be false
    expect(fcm.error?).to be true
    expect(fcm.errors).to eq ["InvalidRegistration"]
    expect(fcm.invalid_token?).to be true
  end

  it "I should receive a notification in real life", ignore_ci: true do
    expect(to = ENV["TEST_FCM_DEVICE_TOKEN"]).to be_present
    Agilibox::FCM::Notifier.call(to: to, body: "Notification from RSpec !")
  end
end
