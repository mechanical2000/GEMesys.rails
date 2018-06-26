require "rails_helper"

describe Agilibox::ActiveModelCustomErrorMessages do
  it "should generate custom error message" do
    o = DummyModel.new
    o.errors.add(:string_field, "^Message without attribute name")
    expect(o.errors.full_messages).to eq ["Message without attribute name"]
  end
end
