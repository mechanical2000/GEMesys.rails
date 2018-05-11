require "rails_helper"

describe Agilibox::SmallData::FilterStrategyByDateOrDatetimePeriod do
  it "should raise error" do
    expect { described_class.new(:date_field) }.to raise_error(RuntimeError, /please use/)
  end
end
