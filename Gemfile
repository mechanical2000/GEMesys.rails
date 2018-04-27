source "https://rubygems.org"

gemspec

gem "rails", "~> 5.0.6"
gem "pg"
gem "puma"
gem "dotenv-rails", require: "dotenv/rails-now"

gem "slim-rails"
gem "sass-rails"
gem "bootstrap-sass"
gem "font-awesome-sass", "~> 4.7.0"
gem "axlsx", github: "randym/axlsx"
gem "aws-sdk-sns"
gem "loofah", ">= 2.2.2" # fix Github security warning

group :test do
  gem "minitest"
  gem "rspec-wait"
  gem "rails-controller-testing"
  gem "rspec-repeat"
  gem "shoulda-matchers"
  gem "cucumber-rails", require: false
  gem "capybara"
  gem "poltergeist"
  gem "spring-commands-rspec"
  gem "spring-commands-cucumber"
  gem "guard"
  gem "guard-cucumber"
  gem "guard-rspec", "4.5.2" # https://github.com/guard/guard-rspec/issues/334
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
  gem "spring"
  gem "launchy"
  gem "rails-erd"
  gem "thor"
  gem "faker"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "byebug"
  gem "rspec-rails" # must be in both environments for generators
  gem "rubocop", "0.55.0", require: false
end
