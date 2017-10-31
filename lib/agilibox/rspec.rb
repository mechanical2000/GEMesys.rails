require_relative "test_helpers"

RSpec.configure do |config|
  config.include Agilibox::TestHelpers

  if defined?(FactoryBot)
    config.include FactoryBot::Syntax::Methods
  end

  if defined?(FactoryGirl)
    warn "Please replace FactoryGirl by FactoryBot"
    config.include FactoryGirl::Syntax::Methods
  end

  if defined?(Devise)
    config.include Devise::Test::ControllerHelpers, type: :controller
  end

  config.after(:each) { Timecop.return }
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Zonebie.set_random_timezone
