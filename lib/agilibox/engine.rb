require "rails-i18n"

module Agilibox
  class Engine < ::Rails::Engine
    isolate_namespace Agilibox
  end
end

require_relative "core_and_rails_ext"
