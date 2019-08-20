class Agilibox::Serializers::Base
  attr_reader :data, :options

  def initialize(data, options = {})
    @data    = data
    @options = options
  end

  def formatted_data
    data.map do |line|
      line.map { |value| self.class.format(value) }
    end
  end

  def render_inline
    raise NotImplementedError
  end

  def render_file(_file_path)
    raise NotImplementedError
  end

  class << self
    def decimals_precision
      @decimals_precision ||= 2
    end

    attr_writer :decimals_precision

    def format_integer(value)
      value
    end

    def format_decimal(value)
      value.to_f.round(decimals_precision) # Fix BigDecimal and 0.1 + 0.2
    end

    def format_boolean(value)
      I18n.t(value.to_s)
    end

    def format_datetime(value)
      Agilibox::AllHelpers.date(value)
    end

    def format_default(value)
      value.to_s
    end

    def formatter_for(value)
      return :integer  if value.is_a?(Integer)
      return :decimal  if value.is_a?(Numeric)
      return :boolean  if value.is_a?(TrueClass) || value.is_a?(FalseClass)
      return :datetime if value.is_a?(Date) || value.is_a?(Time)
      return :default
    end

    def format(value)
      formatter = "format_" + formatter_for(value).to_s
      public_send(formatter, value)
    end
  end # class << self
end
