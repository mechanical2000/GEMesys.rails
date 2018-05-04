class << Agilibox::CucumberConfig = Class.new
  undef new

  attr_writer :phantomjs_version

  def phantomjs_version
    @phantomjs_version ||= "2.1.1"
  end

  attr_writer :window_size

  def window_size
    @window_size ||= [1680, 1050]
  end

  attr_writer :databasecleaner_tables

  def databasecleaner_tables
    @databasecleaner_tables ||= %w(
      ar_internal_metadata
      schema_migrations
      spatial_ref_sys
    )
  end

  def require_all_helpers!
    files = Dir.glob Agilibox::Engine.root.join("lib", "cucumber_helpers", "*.rb")
    files.delete_if { |f| f.match?(/poltergeist|chrome/) }
    files.each { |file| require file }
  end

  def require_poltergeist!
    require Agilibox::Engine.root.join("lib", "cucumber_helpers", "poltergeist.rb")
  end

  def require_chrome_headless!
    require Agilibox::Engine.root.join("lib", "cucumber_helpers", "chrome_headless.rb")
  end
end
