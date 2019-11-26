require "awesome_print"
require "pry-rails"
require "rails-i18n"
require "nilify_blanks"
require "tapenade"

module Agilibox
  class Engine < ::Rails::Engine
    isolate_namespace Agilibox

    initializer "agilibox_mime_types" do
      Mime::Type.register "application/vnd.ms-excel", :xls
      Mime::Type.register "application/vnd.ms-excel", :xlsx
    end

    # initializer "agilibox_errors_middleware" do
    #   require "agilibox/errors_middleware"
    # end
  end
end

require_relative "config"
require_relative "engine_file"
require_relative "core_and_rails_ext"
