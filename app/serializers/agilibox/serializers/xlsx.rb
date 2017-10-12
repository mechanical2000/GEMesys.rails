class Agilibox::Serializers::XLSX < Agilibox::Serializers::Base
  def render_inline
    xlsx.to_stream.read.force_encoding("BINARY")
  end

  def render_file(file_path)
    xlsx.serialize(file_path)
  end

  def xlsx
    @xlsx ||= Axlsx::Package.new do |p|
      p.workbook.add_worksheet do |sheet|
        data.each do |line|
          values = line.map { |value| self.class.format(value) }
          sheet.add_row(values)
        end
      end

      p.use_shared_strings = true
    end
  end
end
