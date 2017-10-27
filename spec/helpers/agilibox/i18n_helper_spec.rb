require "rails_helper"

describe Agilibox::I18nHelper, type: :helper do
  describe "ta" do
    it "should translate action" do
      expect(ta :update).to eq "Modifier"
    end
  end
end
