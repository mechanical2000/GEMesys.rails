class Agilibox::SmallData::FilterStrategyByDateOrDatetimePeriod < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def initialize(*)
    if self.class == Agilibox::SmallData::FilterStrategyByDateOrDatetimePeriod
      raise "please use FilterStrategyByDatePeriod or FilterStrategyByDatetimePeriod"
    end

    super
  end

  def apply(query, value) # rubocop:disable Metrics/MethodLength
    value = value.to_s

    if value == "today"
      a = now
      b = now
    elsif value == "yesterday"
      a = (now - 1.day)
      b = (now - 1.day)
    elsif value == "this_week"
      a = now.beginning_of_week
      b = now.end_of_week
    elsif value == "this_month"
      a = now.beginning_of_month
      b = now.end_of_month
    elsif value == "this_year"
      a = now.beginning_of_year
      b = now.end_of_year
    elsif value == "last_week"
      a = (now - 1.week).beginning_of_week
      b = (now - 1.week).end_of_week
    elsif value == "last_month"
      a = (now - 1.month).beginning_of_month
      b = (now - 1.month).end_of_month
    elsif value == "last_year"
      a = (now - 1.year).beginning_of_year
      b = (now - 1.year).end_of_year
    else
      return query
    end

    if now.is_a?(Time)
      a = a.beginning_of_day
      b = b.end_of_day
    end

    column = key.is_a?(Symbol) ? "#{query.model.table_name}.#{key}" : key.to_s

    query.where("#{column} >= ? AND #{column} <= ?", a, b)
  end
end
