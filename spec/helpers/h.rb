require "rails_helper"

describe H, type: :helper do
  it "should be an alias of Agilibox::AllHelpers" do
    expect(H).to be Agilibox::AllHelpers
  end
end
