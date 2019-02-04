class Agilibox::SmallData::FilterStrategyByKeyValue < ::Agilibox::SmallData::FilterStrategy
  attr_reader :key

  def initialize(key = nil)
    @key = key
  end

  def apply(query, value)
    value = true  if value == "true"
    value = false if value == "false"

    column = column_for(query)

    if value.to_s.in?(%w(nil null))
      query.where("#{column} IS NULL")
    elsif value.to_s.in?(%w(not_nil not_null))
      query.where("#{column} IS NOT NULL")
    else
      query.where("#{column} = ?", value)
    end
  end

  def column_for(query)
    key.is_a?(Symbol) ? "#{query.model.table_name}.#{key}" : key.to_s
  end
end
