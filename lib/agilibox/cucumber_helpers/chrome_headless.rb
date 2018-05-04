Capybara.register_driver :agilibox_chrome_headless do |app|
  window_size = Agilibox::CucumberConfig.window_size.map(&:to_s).join(",")

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    :chromeOptions => {args: %W(headless window-size=#{window_size})},
  )

  Capybara::Selenium::Driver.new(app,
    :browser              => :chrome,
    :desired_capabilities => capabilities,
  )
end

Capybara.default_driver    = :agilibox_chrome_headless
Capybara.current_driver    = :agilibox_chrome_headless
Capybara.javascript_driver = :agilibox_chrome_headless
