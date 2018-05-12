require "rails_helper"

RSpec.describe Agilibox::SortableUUIDGenerator do
  it "should generate a valid uuid" do
    uuid = described_class.call
    expect(uuid).to match described_class::REGEX_WITH_DASHES
  end

  it "should still work in 100 years" do
    Timecop.travel "2116-11-17"
    uuid = described_class.call
    expect(uuid).to match described_class::REGEX_WITH_DASHES
  end

  it "should be incremental" do
    uuids = []
    1_000.times { uuids << described_class.call }
    Timecop.travel 1.day.from_now
    1_000.times { uuids << described_class.call }
    Timecop.travel 1.month.from_now
    1_000.times { uuids << described_class.call }
    Timecop.travel 1.year.from_now
    1_000.times { uuids << described_class.call }
    Timecop.travel 10.years.from_now
    1_000.times { uuids << described_class.call }

    expect(uuids).to eq uuids.dup.sort
  end
end
