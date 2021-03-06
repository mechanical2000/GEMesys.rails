class Agilibox::SmallData::FilterStrategyByDateEnd < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = Date.parse(value)
    column = column_for(query)
    query.where("#{column} <= ?", value)
  end
end
