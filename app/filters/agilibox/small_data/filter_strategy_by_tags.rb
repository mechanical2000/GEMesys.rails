class Agilibox::SmallData::FilterStrategyByTags < ::Agilibox::SmallData::FilterStrategy
  def apply(query, value)
    value = [*value].flatten.select{ |v| v.present? }

    if value.any?
      query.tagged_with(value)
    else
      query
    end
  end
end
