class Agilibox::FCM::Request < Agilibox::Service
  URL = "https://fcm.googleapis.com/fcm/send"

  class << self
    attr_writer :api_key

    def api_key
      @api_key ||= ENV["FCM_API_KEY"]
    end
  end

  initialize_with :request_body

  attr_reader :response_json

  def call
    response_body = HTTParty.post(URL,
      :body    => request_body.to_json,
      :headers => {
        "Content-Type"  => "application/json",
        "Authorization" => "key=#{self.class.api_key}",
      },
    ).body

    @response_json = JSON.parse(response_body).deep_symbolize_keys

    self
  rescue JSON::ParserError
    @response_json = {success: 0, failure: 1, results: [{:error => "InvalidJsonResponse"}]}
    self
  end

  def ok?
    response_json[:success].positive? && response_json[:failure].zero?
  end

  def error?
    !ok?
  end

  def errors
    response_json[:results].map { |r| r[:error] }.compact
  end

  def invalid_token?
    errors.include?("NotRegistered") || errors.include?("InvalidRegistration")
  end
end
