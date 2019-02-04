class Agilibox::SmallData::FilterStrategyByDateEnd < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = Time.zone.parse(value).end_of_day
    column = column_for(query)
    query.where("#{column} <= ?", value)
  end
end
