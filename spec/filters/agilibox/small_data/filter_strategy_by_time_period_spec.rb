require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByTimePeriod do
  it "should raise error" do
    expect { described_class.new(:date_field) }.to raise_error(RuntimeError, /deprecated/)
  end
end
