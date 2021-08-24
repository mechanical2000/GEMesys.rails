class Agilibox::Serializers::XLSX < Agilibox::Serializers::Base
  def render_inline
    headers, *data = formatted_data

    SpreadsheetArchitect.to_xlsx(
      headers: headers,
      data: data,
      freeze_headers: true,
      range_styles: range_styles(data[0]),
    )
  end

  def render_file(file_path)
    File.open(file_path, "w+b") do |f|
      f.write(render_inline)
    end
  end

  private

  def range_styles(row)
    return [] if row.nil?

    date_range_styles(row) + time_range_styles(row)
  end

  def date_range_styles(row)
    row.each_index.select { row[_1].is_a?(Date) }.map do
      {range: {rows: :all, columns: _1}, styles: {format_code: "dd/mm/yyyy"}}
    end
  end

  def time_range_styles(row)
    row.each_index.select { row[_1].is_a?(Time) }.map do
      {range: {rows: :all, columns: _1}, styles: {format_code: "dd/mm/yyyy hh:mm:ss"}}
    end
  end
end
