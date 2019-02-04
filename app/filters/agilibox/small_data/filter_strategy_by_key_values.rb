class Agilibox::SmallData::FilterStrategyByKeyValues < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = value.split(" ") if value.is_a?(String)
    value = value.select(&:present?)
    column = column_for(query)

    if value.any?
      query.where("#{column} IN (?)", value)
    else
      query
    end
  end
end
