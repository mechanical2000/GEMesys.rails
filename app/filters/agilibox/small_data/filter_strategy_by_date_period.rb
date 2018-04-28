class Agilibox::SmallData::FilterStrategyByDatePeriod < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = value.to_s

    if value == "today"
      a = Date.current
      b = Date.current
    elsif value == "yesterday"
      a = (Date.current - 1.day)
      b = (Date.current - 1.day)
    elsif value == "this_week"
      a = Date.current.beginning_of_week
      b = Date.current.end_of_week
    elsif value == "this_month"
      a = Date.current.beginning_of_month
      b = Date.current.end_of_month
    elsif value == "this_year"
      a = Date.current.beginning_of_year
      b = Date.current.end_of_year
    elsif value == "last_week"
      a = (Date.current - 1.week).beginning_of_week
      b = (Date.current - 1.week).end_of_week
    elsif value == "last_month"
      a = (Date.current - 1.month).beginning_of_month
      b = (Date.current - 1.month).end_of_month
    elsif value == "last_year"
      a = (Date.current - 1.year).beginning_of_year
      b = (Date.current - 1.year).end_of_year
    else
      return query
    end

    column = key.is_a?(Symbol) ? "#{query.model.table_name}.#{key}" : key.to_s

    query.where("#{column} >= ? AND #{column} <= ?", a, b)
  end
end
