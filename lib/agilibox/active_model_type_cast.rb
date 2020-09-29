module Agilibox::ActiveModelTypeCast
  module Decimal
    def cast_value(value)
      if value.is_a?(String)
        super value.tr(",", ".").gsub(/[^-0-9.]/, "")
      else
        super value
      end
    end
  end

  module Date
    # rubocop:disable Style/RegexpLiteral
    SANITIZABLE_FORMATS = [
      /^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/,
      /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/,
    ]
    # rubocop:enable Style/RegexpLiteral

    def cast_value(value)
      if sanitizable?(value)
        super sanitize(value)
      else
        super value
      end
    end

    private

    def sanitize(value)
      value.delete(" ")
    end

    def sanitizable?(value)
      return false unless value.is_a?(String)
      sanitized = sanitize(value)
      SANITIZABLE_FORMATS.any? { |r| r =~ sanitized }
    end
  end

  module Boolean
    def cast_value(value)
      value = value.strip if value.is_a?(String)
      super value
    end
  end
end

ActiveModel::Type::Date.prepend(Agilibox::ActiveModelTypeCast::Date)
ActiveModel::Type::Boolean.prepend(Agilibox::ActiveModelTypeCast::Boolean)
ActiveModel::Type::Decimal.prepend(Agilibox::ActiveModelTypeCast::Decimal)
ActiveModel::Type::Float.prepend(Agilibox::ActiveModelTypeCast::Decimal)
