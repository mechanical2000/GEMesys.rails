module Agilibox::BackUrlConcern
  extend ActiveSupport::Concern

  private

  def default_back_url
  end

  def back_url
    url = [
      params[:back_url],
      request.referer,
      default_back_url,
      main_app.try(:root_path),
      "/",
    ].select(&:present?).first

    uri = URI.parse(url)
    uri.host = nil
    uri.port = nil
    uri.scheme = nil
    uri.user = nil
    uri.password = nil
    uri.to_s
  end
end
