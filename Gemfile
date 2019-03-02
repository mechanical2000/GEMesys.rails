source "https://rubygems.org"

gemspec

gem "rails", "~> 5.1.6"
gem "pg"
gem "puma"
gem "dotenv-rails", require: "dotenv/rails-now"

gem "slim-rails"
gem "sass-rails"
gem "bootstrap-sass"
gem "font-awesome-sass", ">= 5.0.0"
gem "coffee-rails"
gem "jquery-rails"
gem "turbolinks"
gem "simple_form"
gem "httparty"
gem "axlsx", github: "randym/axlsx"
gem "aws-sdk-sns"

group :test do
  gem "minitest"
  gem "rspec-wait"
  gem "rails-controller-testing"
  gem "rspec-repeat"
  gem "shoulda-matchers"
  gem "cucumber-rails", require: false
  gem "capybara"
  gem "poltergeist"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "guard"
  gem "guard-cucumber"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "timecop"
  gem "simplecov", require: false
  gem "pundit-matchers"
  gem "zonebie"
end

group :development do
  gem "desktop_delivery"
  gem "better_errors"
  gem "meta_request"

  # Please do not use this gem, it create Rails reloader problems
  # gem "binding_of_caller"
end

group :development, :test do
  gem "launchy"
  gem "rails-erd"
  gem "thor"
  gem "faker"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "byebug"
  gem "rspec-rails" # must be in both environments for generators
  gem "rubocop", "0.65.0", require: false
end
