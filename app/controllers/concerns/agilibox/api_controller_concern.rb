module Agilibox::ApiControllerConcern
  extend ActiveSupport::Concern

  private

  def render_json(json = {}, options = {})
    json.reverse_merge!(current_user: current_user)
    options.reverse_merge!(current_user: current_user)

    json = Agilibox::MiniModelSerializer::Serialize.call(json, options)

    render options.merge(json: json)
  end

  def render_json_error(any_object, options = {})
    if any_object.is_a?(ActiveModel::Validations)
      json = {
        :error        => json_error_string_for_model(any_object),
        :model_errors => json_errors_hash_for_model(any_object),
      }
    elsif any_object.is_a?(String)
      json = {error: any_object}
    else
      json = any_object
    end

    options[:status] ||= :unprocessable_entity

    render_json(json, options)
  end

  def json_errors_hash_for_model(object)
    object.errors
      .map { |a, m| [a, message: m, full_message: object.errors.full_message(a, m)] }
      .uniq(&:first)
      .to_h
  end

  def json_error_string_for_model(object)
    json_errors_hash_for_model(object).values.map { |e| e[:full_message] }.join(", ")
  end

  def render_not_found
    render_json_error t("errors.not_found"), status: :not_found
  end

  def render_forbidden
    render_json_error t("errors.forbidden"), status: :forbidden
  end

  def render_unauthorized
    render_json_error t("errors.unauthorized"), status: :unauthorized
  end

  def render_forbidden_or_unauthorized
    current_user ? render_unauthorized : render_forbidden
  end

  included do |controller|
    if controller < ActionController::Rescue
      if defined?(Pundit::NotAuthorizedError)
        rescue_from Pundit::NotAuthorizedError, with: :render_forbidden_or_unauthorized
      end

      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    end
  end
end
