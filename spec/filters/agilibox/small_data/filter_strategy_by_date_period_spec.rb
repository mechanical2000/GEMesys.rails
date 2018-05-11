require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByDatePeriod do
  def create!(date_field, string_field)
    DummyModel.create!(date_field: date_field, string_field: string_field)
  end

  before do
    Timecop.freeze Time.zone.parse("2016-11-08 12:00:00")

    @today      = create!("2016-11-08", "today")
    @yesterday  = create!("2016-11-07", "yesterday")
    @tomorrow   = create!("2016-11-09", "tomorrow")
    @last_week  = create!("2016-11-04", "last_week")
    @last_month = create!("2016-10-18", "last_month")
    @last_year  = create!("2015-10-18", "last_year")
  end

  def filter(period)
    described_class
      .new(:date_field)
      .apply(DummyModel.all, period)
      .map(&:string_field)
      .map(&:to_sym)
  end

  it "should filter by all_time" do
    expect(filter :all_time).to \
      contain_exactly(:today, :yesterday, :tomorrow, :last_week, :last_month, :last_year)
  end

  it "should filter by today" do
    expect(filter :today).to contain_exactly(:today)
  end

  it "should filter by yesterday" do
    expect(filter :yesterday).to contain_exactly(:yesterday)
  end

  it "should filter by this_week" do
    expect(filter :this_week).to contain_exactly(:today, :yesterday, :tomorrow)
  end

  it "should filter by this_month" do
    expect(filter :this_month).to contain_exactly(:today, :yesterday, :tomorrow, :last_week)
  end

  it "should filter by this_year" do
    expect(filter :this_year).to \
      contain_exactly(:today, :yesterday, :tomorrow, :last_week, :last_month)
  end

  it "should filter by last_week" do
    expect(filter :last_week).to contain_exactly(:last_week)
  end

  it "should filter by last_month" do
    expect(filter :last_month).to contain_exactly(:last_month)
  end

  it "should filter by last_year" do
    expect(filter :last_year).to contain_exactly(:last_year)
  end

  describe "custom period" do
    it "should filter by last custom period using last" do
      @two_months_ago = create!("2016-09-15", "two_months_ago")

      expect(filter "last.3.months").to \
        contain_exactly(:today, :yesterday, :last_week, :last_month, :two_months_ago)
    end
  end # describe "custom period"
end
