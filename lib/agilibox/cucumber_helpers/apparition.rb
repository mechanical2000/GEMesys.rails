require "capybara/apparition"

Capybara.register_driver :agilibox_apparition do |app|
  Capybara::Apparition::Driver.new(app,
    :browser_options => {
      :"disable-gpu" => true,
      :"no-sandbox" => nil,
    },
    :headless => (ENV["CHROME_HEADLESS"].to_s != "false"),
    :inspector => true,
    :js_errors => true,
    :window_size => Agilibox::CucumberConfig.window_size,
  )
end

Capybara.default_driver    = :agilibox_apparition
Capybara.current_driver    = :agilibox_apparition
Capybara.javascript_driver = :agilibox_apparition
