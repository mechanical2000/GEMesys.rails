module Agilibox::TestHelpers
  def json_response
    @json_response ||= JSON.parse(response.body).with_indifferent_access
  end

  def email_deliveries
    ActionMailer::Base.deliveries
  end

  def sms_deliveries
    Agilibox::SMS::Strategies::Test.deliveries
  end
end
