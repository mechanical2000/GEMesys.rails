module Agilibox::RoutesHelper
  def engine_polymorphic_path(obj, opts = {})
    if Rails::VERSION::STRING >= "6.0.0"
      engine = obj.class.module_parents[-2]
    else
      engine = obj.class.parents[-2]
    end

    if engine.nil?
      routes = main_app
    else
      routes = engine::Engine.routes
    end

    opts = {
      :controller => "/#{obj.class.to_s.tableize}",
      :action     => :show,
      :id         => obj.to_param,
      :only_path  => true,
    }.merge(opts)

    routes.url_for(opts)
  end
end
