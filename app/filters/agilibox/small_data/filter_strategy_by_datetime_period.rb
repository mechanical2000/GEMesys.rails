class Agilibox::SmallData::FilterStrategyByDatetimePeriod < ::Agilibox::SmallData::FilterStrategyByDateOrDatetimePeriod
  def now
    Time.zone.now
  end
end
