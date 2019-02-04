class Agilibox::SmallData::FilterStrategyByDateBegin < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = Time.zone.parse(value).beginning_of_day
    column = column_for(query)
    query.where("#{column} >= ?", value)
  end
end
