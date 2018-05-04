require "capybara/poltergeist"

phantomjs_version = Agilibox::CucumberConfig.phantomjs_version
phantomjs_binary = `which phantomjs-#{phantomjs_version} phantomjs`.split("\n").first
raise "invalid phantomjs version" if `#{phantomjs_binary} -v`.strip != phantomjs_version
# You can download phantomjs here : https://bitbucket.org/ariya/phantomjs/downloads/
# Semaphore setup commmand : change-phantomjs-version 2.1.1

Capybara.register_driver :agilibox_poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    :debug       => false,
    :window_size => Agilibox::CucumberConfig.window_size,
    :timeout     => 60,
    :phantomjs   => phantomjs_binary,
  )
end

Capybara.default_driver    = :agilibox_poltergeist
Capybara.javascript_driver = :agilibox_poltergeist
Capybara.current_driver    = :agilibox_poltergeist
