require "capybara/poltergeist"

phantomjs_version = Agilibox::CucumberConfig.phantomjs_version
phantomjs_binary = `which phantomjs-#{phantomjs_version} phantomjs`.split("\n").first
raise "invalid phantomjs version" if `#{phantomjs_binary} -v`.strip != phantomjs_version
# You can download phantomjs here : https://bitbucket.org/ariya/phantomjs/downloads/
# Semaphore setup commmand : change-phantomjs-version 2.1.1

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    :debug       => false,
    :window_size => Agilibox::CucumberConfig.phantomjs_window_size,
    :timeout     => 60,
    :phantomjs   => phantomjs_binary,
  )
end

Capybara.default_driver        = :poltergeist
Capybara.javascript_driver     = :poltergeist
Capybara.current_driver        = :poltergeist
Capybara.default_max_wait_time = 3
