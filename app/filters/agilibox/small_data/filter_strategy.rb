class Agilibox::SmallData::FilterStrategy
  def apply(query, value)
    raise NotImplementedError
  end
end
