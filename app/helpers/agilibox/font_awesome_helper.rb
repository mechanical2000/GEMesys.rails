module Agilibox::FontAwesomeHelper
  def icon(id, fa_style: nil, size: nil, spin: false, **options)
    id = id.to_s.tr("_", "-").to_sym

    if fa_style.nil?
      fa_style = Agilibox::FontAwesomeHelper.default_fa_style_for_id(id)
    end

    css_classes = options.delete(:class).to_s.split
    css_classes << "icon"
    css_classes << "fa-#{id}"
    css_classes << "fa#{fa_style.to_s[0]}"
    css_classes << "fa-#{size}" if size
    css_classes << "fa-spin" if spin

    attributes = options.merge(class: css_classes.sort.join(" ")).sort.to_h

    tag.span(**attributes)
  end

  class << self
    def database
      @database ||= YAML.safe_load(database_yml).deep_symbolize_keys
    end

    def database_path
      Rails.root.join("tmp", "fa_database_#{version}.yml")
    end

    def database_yml
      download_database! unless File.size?(database_path)
      File.read(database_path)
    end

    def database_url
      short_version = version.split(".")[0, 3].join(".") # 1.20.14.2 => 1.20.14
      url = "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/#{short_version}/metadata/icons.yml"

      if Gem::Version.new(short_version) < Gem::Version.new("5.6.0")
        url = url.gsub("/metadata", "/advanced-options/metadata")
      end

      url
    end

    def download_database!
      require "open-uri"
      data = URI.parse(database_url).open.read
      File.write(database_path, data)
    end

    def version
      require "font_awesome/sass/version"
      FontAwesome::Sass::VERSION
    end

    def default_fa_style_for_id(id)
      return if version.start_with?("4")

      if version.start_with?("5")
        return Agilibox::FontAwesomeHelper.database.dig(id, :styles).to_a.first
      end

      raise "invalid font-awesome-sass version"
    end
  end # class << self
end
