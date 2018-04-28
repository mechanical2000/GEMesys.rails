require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByDatetimePeriod do
  before do
    Timecop.freeze Time.zone.parse("2016-11-08 12:00:00")

    @today      = DummyModel.create!(datetime_field: "2016-11-08 12:00:00")
    @yesterday  = DummyModel.create!(datetime_field: "2016-11-07 12:00:00")
    @tomorrow   = DummyModel.create!(datetime_field: "2016-11-09 12:00:00")
    @last_week  = DummyModel.create!(datetime_field: "2016-11-04 12:00:00")
    @last_month = DummyModel.create!(datetime_field: "2016-10-18 12:00:00")
    @last_year  = DummyModel.create!(datetime_field: "2015-10-18 12:00:00")
  end

  def filter(period)
    described_class.new(:datetime_field).apply(DummyModel.all, period)
  end

  it "should filter by all_time" do
    expect(filter :all_time).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week, @last_month, @last_year)
  end

  it "should filter by today" do
    expect(filter :today).to contain_exactly(@today)
  end

  it "should filter by yesterday" do
    expect(filter :yesterday).to contain_exactly(@yesterday)
  end

  it "should filter by this_week" do
    expect(filter :this_week).to contain_exactly(@today, @yesterday, @tomorrow)
  end

  it "should filter by this_month" do
    expect(filter :this_month).to contain_exactly(@today, @yesterday, @tomorrow, @last_week)
  end

  it "should filter by this_year" do
    expect(filter :this_year).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week, @last_month)
  end

  it "should filter by last_week" do
    expect(filter :last_week).to contain_exactly(@last_week)
  end

  it "should filter by last_month" do
    expect(filter :last_month).to contain_exactly(@last_month)
  end

  it "should filter by last_year" do
    expect(filter :last_year).to contain_exactly(@last_year)
  end
end
