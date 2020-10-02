class Agilibox::Serializers::XLSX < Agilibox::Serializers::Base
  def render_inline
    headers, *data = formatted_data
    SpreadsheetArchitect.to_xlsx(headers: headers, data: data, freeze_headers: true)
  end

  def render_file(file_path)
    File.open(file_path, "w+b") do |f|
      f.write(render_inline)
    end
  end
end
