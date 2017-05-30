require "rails-i18n"

module Agilibox
  class Engine < ::Rails::Engine
    isolate_namespace Agilibox

    initializer "agilibox_mime_types" do
      Mime::Type.register "application/vnd.ms-excel", :xls
      Mime::Type.register "application/vnd.ms-excel", :xlsx
    end
  end
end

require_relative "core_and_rails_ext"
