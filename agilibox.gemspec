$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "agilibox/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "agilibox"
  s.version     = Agilibox::VERSION
  s.authors     = ["agilidée"]
  s.email       = ["contact@agilidee.com"]
  s.homepage    = "https://github.com/agilidee/agilibox"
  s.summary     = "Agilibox"
  s.description = "Agilibox"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md", "CHANGELOG.md"]

  s.add_dependency "rails-i18n"
  s.add_dependency "awesome_print"
  s.add_dependency "pry-rails"
end
