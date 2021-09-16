class Agilibox::SmallData::FilterStrategyByDateBegin < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = Date.parse(value)
    column = column_for(query)
    query.where("#{column} >= ?", value)
  end
end
