class << Agilibox::CucumberConfig = Class.new
  undef new

  attr_writer :phantomjs_version

  def phantomjs_version
    @phantomjs_version ||= "2.1.1"
  end

  attr_writer :cuprite_timeout

  def cuprite_timeout
    @cuprite_timeout ||= 15
  end

  attr_writer :cuprite_process_timeout

  def cuprite_process_timeout
    @cuprite_process_timeout ||= 15
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
    files = Dir.glob Agilibox::Engine.root.join("lib", "agilibox", "cucumber_helpers", "*.rb")
    files.delete_if { |f| f.match?(/poltergeist|chrome|cuprite|_steps/) }
    files.each { |file| require file }
  end

  def require_poltergeist!
    require Agilibox::Engine.root.join("lib", "agilibox", "cucumber_helpers", "poltergeist.rb")
  end

  def require_chrome_headless!
    require Agilibox::Engine.root.join("lib", "agilibox", "cucumber_helpers", "chrome_headless.rb")
  end

  def require_cuprite!
    require Agilibox::Engine.root.join("lib", "agilibox", "cucumber_helpers", "cuprite.rb")
  end

  def require_common_steps!
    require Agilibox::Engine.root.join("lib", "agilibox", "cucumber_helpers", "common_steps.rb")
  end
end
