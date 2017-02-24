class Agilibox::SmallData::FilterStrategyByDate < ::Agilibox::SmallData::FilterStrategyByKeyValue
  def apply(query, value)
    value = Date.parse(value)
    super(query, value)
  end
end
