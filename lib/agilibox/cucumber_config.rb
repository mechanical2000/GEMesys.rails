class << Agilibox::CucumberConfig = Class.new
  undef new

  attr_writer :phantomjs_version

  def phantomjs_version
    @phantomjs_version ||= "2.1.1"
  end

  attr_writer :phantomjs_window_size

  def phantomjs_window_size
    @phantomjs_window_size ||= [1680, 1050]
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
    files = Dir.glob Agilibox::Engine.root.join("features/support/*.rb")
    files.each { |file| require file }
  end
end
