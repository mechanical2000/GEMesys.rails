source "https://rubygems.org"

gemspec

gem "rails", "~> 6.0.3"
gem "pg"
gem "puma"
gem "dotenv-rails", require: "dotenv/rails-now"

gem "bootsnap"
gem "slim-rails"
gem "sass-rails"
gem "bootstrap"
gem "font-awesome-sass", ">= 5.0.0"
gem "coffee-rails"
gem "jquery-rails"
gem "turbolinks"
gem "simple_form"
gem "httparty"
gem "spreadsheet_architect"
gem "aws-sdk-sns"
gem "sprockets", "< 4" # TODO : Remove

group :test do
  gem "minitest"
  gem "rspec-wait"
  gem "rails-controller-testing"
  gem "rspec-repeat"
  gem "shoulda-matchers"
  gem "cucumber-rails", require: false
  gem "capybara", "3.34.0"
  gem "cuprite"
  gem "timecop"
  gem "simplecov", require: false
  gem "pundit-matchers"
  gem "zonebie"
end

group :development do
  gem "desktop_delivery"
  gem "better_errors"
end

group :development, :test do
  gem "listen"
  gem "launchy"
  gem "rails-erd"
  gem "thor"
  gem "faker"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "byebug"
  gem "rspec-rails" # must be in both environments for generators
  gem "rubocop", "1.6.1", require: false
  gem "rubocop-performance", "1.9.1", require: false
  gem "rubocop-rails", "2.9.1", require: false
end
