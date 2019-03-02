class Agilibox::GetHTTP < Agilibox::Service
  class Error < StandardError
  end

  EXCEPTIONS_TO_RERAISE = [
    IOError,
    Net::HTTPBadResponse,
    Net::HTTPExceptions,
    Net::HTTPHeaderSyntaxError,
    OpenSSL::SSL::SSLError,
    SocketError,
    SystemCallError,
    Timeout::Error,
    Zlib::Error,
  ]

  TIMEOUT = 10

  initialize_with :url

  def uri
    uri = URI(url.to_s)
    raise Error, "invalid URI type : #{uri.class}" unless uri.is_a?(URI::HTTP)
    uri
  end

  def response
    @response ||= fetch_response
  end

  def call
    response.body
  end

  private

  def fetch_response
    http_response = Timeout.timeout(TIMEOUT) do
      Net::HTTP.get_response(uri)
    end

    if http_response.code.start_with?("3")
      @url = http_response["Location"]
      return fetch_response
    end

    unless http_response.code.start_with?("2")
      raise Error, "invalid response code : #{http_response.code}"
    end

    http_response
  rescue *EXCEPTIONS_TO_RERAISE => e
    raise Error, e.message
  end
end
