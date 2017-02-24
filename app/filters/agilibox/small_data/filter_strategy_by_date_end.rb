class Agilibox::SmallData::FilterStrategyByDateEnd < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = Time.parse(value).end_of_day
    query.where("#{key} <= ?", value)
  end
end
