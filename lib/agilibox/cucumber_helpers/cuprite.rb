require "capybara/cuprite"

Capybara.register_driver :agilibox_cuprite do |app|
  Capybara::Cuprite::Driver.new(app,
    :browser_options => {
      :"disable-gpu" => true,
      :"no-sandbox" => nil,
    },
    :headless => (ENV["CHROME_HEADLESS"].to_s != "false"),
    :inspector => true,
    :js_errors => true,
    :process_timeout => 5,
    :window_size => Agilibox::CucumberConfig.window_size,
  )
end

Capybara.default_driver    = :agilibox_cuprite
Capybara.current_driver    = :agilibox_cuprite
Capybara.javascript_driver = :agilibox_cuprite
