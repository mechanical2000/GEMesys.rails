Capybara.register_driver :agilibox_no_driver do |_app|
  raise \
    "You need to add Agilibox::CucumberConfig.require_cuprite! or " \
    "Agilibox::CucumberConfig.require_chrome_headless! " \
    "to your features/support/env.rb"
end

Capybara.default_driver    = :agilibox_no_driver
Capybara.current_driver    = :agilibox_no_driver
Capybara.javascript_driver = :agilibox_no_driver

Capybara.default_max_wait_time = 3
