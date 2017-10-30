module Agilibox::ApiControllerConcern
  extend ActiveSupport::Concern

  private

  def render_json(json = {}, options = {})
    json.reverse_merge!(current_user: current_user)
    options.reverse_merge!(current_user: current_user)

    json = Agilibox::MiniModelSerializer::Serialize.call(json, options)

    render options.merge(json: json)
  end

  def render_json_error(message_or_object, options = {})
    if message_or_object.is_a?(ActiveRecord::Base)
      message = message_or_object.errors.full_messages.join(", ")
    else
      message = message_or_object
    end

    options[:status] ||= :unprocessable_entity

    render_json({error: message}, options)
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
