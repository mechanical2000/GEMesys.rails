require "rails_helper"

class TestSMS < Agilibox::SMS::ApplicationSMS
  def hello
    sms to: "09 88 77 66 55", body: "Hello"
  end

  def hello_i18n_relative
    sms body: t(".hello")
  end

  def hello_i18n_absolute
    sms body: t("hello")
  end
end

describe Agilibox::SMS::ApplicationSMS do
  it "should send sms" do
    expect {
      TestSMS.hello.deliver_now
    }.to change(sms_deliveries, :count).by(1)

    sms = sms_deliveries.last
    expect(sms[:to]).to eq "09 88 77 66 55"
    expect(sms[:body]).to eq "Hello"
  end

  it "should should translate relative key" do
    expect(I18n).to receive(:t).with("test_sms.hello_i18n_relative.hello").and_return("Hello")
    TestSMS.hello_i18n_relative.deliver_now
  end

  it "should should translate relative key" do
    expect(I18n).to receive(:t).with("hello").and_return("Hello")
    TestSMS.hello_i18n_absolute.deliver_now
  end
end
