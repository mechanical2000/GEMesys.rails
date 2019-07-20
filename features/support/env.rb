ENV["RAILS_ROOT"] ||= File.expand_path("../../spec/dummy", __dir__)
require "cucumber/rails"
require "agilibox/cucumber_config"
Agilibox::CucumberConfig.require_all_helpers!
Agilibox::CucumberConfig.require_cuprite!
Agilibox::CucumberConfig.require_common_steps!
