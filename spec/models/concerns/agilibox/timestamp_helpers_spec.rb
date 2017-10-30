require "rails_helper"

describe Agilibox::TimestampHelpers do
  subject { DummyModel }

  it { is_expected.to respond_to :first_created }
  it { is_expected.to respond_to :last_created }
  it { is_expected.to respond_to :last_updated }
end
