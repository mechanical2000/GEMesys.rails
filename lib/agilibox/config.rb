class << Agilibox
  attr_writer :parent_controller

  def parent_controller
    @parent_controller ||= [
      "ApplicationController",
      "ActionController::Base",
    ].map(&:safe_constantize).compact.first
  end

  attr_writer :parent_mailer

  def parent_mailer
    @parent_mailer ||= [
      "ApplicationMailer",
      "ActionMailer::Base",
    ].map(&:safe_constantize).compact.first
  end
end
