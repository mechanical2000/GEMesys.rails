class Agilibox::SmallData::FiltersController < ::Agilibox::ApplicationController
  skip_after_action  :verify_authorized,         raise: false
  skip_after_action  :verify_policy_scoped,      raise: false
  skip_before_action :verify_authenticity_token, raise: false

  def create
    skip_authorization if respond_to?(:skip_authorization)
    skip_policy_scope  if respond_to?(:skip_policy_scope)

    filters = ::Agilibox::SmallData::Filter.new(cookies)
    new_filters = params.fetch(:filters, {}).permit!.to_h
    filters.merge new_filters

    # Rewrite cookie with 1 year expiry
    cookies[:filters] = {
      :value   => cookies[:filters],
      :expires => 1.year.from_now,
      :path    => "/",
    }

    redirect_to back_url
  end

  private

  def back_url
    url = [
      params[:form_url],
      request.referer,
      main_app.try(:root_path),
      "/",
    ].find(&:present?)

    # Delete page param
    base, query_string = url.split("?")
    query_string = query_string.to_s.split("&").delete_if { |p| p.include?("page=") }.join("&")
    query_string = "?#{query_string}" if query_string.present?
    base + query_string
  end
end
