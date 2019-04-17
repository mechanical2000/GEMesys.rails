require "capybara/cuprite"

Capybara.register_driver :agilibox_cuprite do |app|
  Capybara::Cuprite::Driver.new(app,
    :inspector   => true,
    :window_size => Agilibox::CucumberConfig.window_size,
  )
end

Capybara.default_driver    = :agilibox_cuprite
Capybara.current_driver    = :agilibox_cuprite
Capybara.javascript_driver = :agilibox_cuprite
