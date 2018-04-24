require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByTimePeriod do
  def create!(attributes)
    DummyModel.create!(attributes)
  end

  before do
    Timecop.freeze Time.zone.parse("2016-11-08 12:00:00")

    @today      = create!(date_field: "2016-11-08", datetime_field: "2016-11-08 12:00:00")
    @yesterday  = create!(date_field: "2016-11-07", datetime_field: "2016-11-07 12:00:00")
    @tomorrow   = create!(date_field: "2016-11-09", datetime_field: "2016-11-09 12:00:00")
    @last_week  = create!(date_field: "2016-11-04", datetime_field: "2016-11-04 12:00:00")
    @last_month = create!(date_field: "2016-10-18", datetime_field: "2016-10-18 12:00:00")
    @last_year  = create!(date_field: "2015-10-18", datetime_field: "2015-10-18 12:00:00")
  end

  def filter_on_date_field(period)
    described_class.new(:date_field).apply(DummyModel.all, period)
  end

  def filter_on_datetime_field(period)
    described_class.new(:datetime_field).apply(DummyModel.all, period)
  end

  it "should filter by all_time" do
    expect(filter_on_date_field :all_time).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week, @last_month, @last_year)

    expect(filter_on_datetime_field :all_time).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week, @last_month, @last_year)
  end

  it "should filter by today" do
    expect(filter_on_date_field :today).to contain_exactly(@today)
    expect(filter_on_datetime_field :today).to contain_exactly(@today)
  end

  it "should filter by yesterday" do
    expect(filter_on_date_field :yesterday).to contain_exactly(@yesterday)
    expect(filter_on_datetime_field :yesterday).to contain_exactly(@yesterday)
  end

  it "should filter by this_week" do
    expect(filter_on_date_field :this_week).to contain_exactly(@today, @yesterday, @tomorrow)
    expect(filter_on_datetime_field :this_week).to contain_exactly(@today, @yesterday, @tomorrow)
  end

  it "should filter by this_month" do
    expect(filter_on_date_field :this_month).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week)

    expect(filter_on_datetime_field :this_month).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week)
  end

  it "should filter by this_year" do
    expect(filter_on_date_field :this_year).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week, @last_month)

    expect(filter_on_datetime_field :this_year).to \
      contain_exactly(@today, @yesterday, @tomorrow, @last_week, @last_month)
  end

  it "should filter by last_week" do
    expect(filter_on_date_field :last_week).to contain_exactly(@last_week)
    expect(filter_on_datetime_field :last_week).to contain_exactly(@last_week)
  end

  it "should filter by last_month" do
    expect(filter_on_date_field :last_month).to contain_exactly(@last_month)
    expect(filter_on_datetime_field :last_month).to contain_exactly(@last_month)
  end

  it "should filter by last_year" do
    expect(filter_on_date_field :last_year).to contain_exactly(@last_year)
    expect(filter_on_datetime_field :last_year).to contain_exactly(@last_year)
  end
end
