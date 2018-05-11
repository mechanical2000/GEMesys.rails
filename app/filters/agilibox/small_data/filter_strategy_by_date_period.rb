class Agilibox::SmallData::FilterStrategyByDatePeriod < ::Agilibox::SmallData::FilterStrategyByDateOrDatetimePeriod
  def now
    Date.current
  end
end
