require "rails-i18n"

require_relative "core_and_rails_ext"

module Agilibox
  class Engine < ::Rails::Engine
    isolate_namespace Agilibox
  end
end
