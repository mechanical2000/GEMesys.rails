class Agilibox::SmallData::FilterStrategyByKeyValues < ::Agilibox::SmallData::FilterStrategy
  attr_reader :key

  def initialize(key = nil)
    @key = key
  end

  def apply(query, value)
    value = value.split(" ") if value.is_a?(String)
    value = value.select(&:present?)

    if value.any?
      query.where("#{key} IN (?)", value)
    else
      query
    end
  end
end
