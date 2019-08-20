class Agilibox::Serializers::XLSX < Agilibox::Serializers::Base
  def render_inline
    SpreadsheetArchitect.to_xlsx(data: formatted_data)
  end

  def render_file(file_path)
    File.open(file_path, "w+b") do |f|
      f.write(render_inline)
    end
  end
end
