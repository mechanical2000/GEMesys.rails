class Agilibox::ErrorsMiddleware
  MAINTENANCE_ERRORS = [
    PG::ConnectionBad,
    PG::UnableToSend,
  ]

  NOT_ACCEPTABLE_ERRORS = [
    ActionController::UnknownFormat,
    ActionController::UnknownHttpMethod,
    ActionView::MissingTemplate,
  ]

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue *MAINTENANCE_ERRORS
    respond_with 503, "Maintenance en cours."
  rescue *NOT_ACCEPTABLE_ERRORS
    respond_with 406, "Not acceptable."
  end

  private

  def respond_with(status, body)
    [status, {"Content-Type" => "text/plain; charset=UTF-8"}, [body]]
  end
end

stack = Rails.configuration.middleware
mw = Agilibox::ErrorsMiddleware
stack.unshift(mw)
stack.insert_after(ActionDispatch::DebugExceptions, mw) if defined?(ActionDispatch::DebugExceptions)
stack.insert_after(Bugsnag::Rack, mw) if defined?(Bugsnag::Rack)
stack.use(mw)
