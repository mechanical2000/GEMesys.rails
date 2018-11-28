require "rails_helper"

describe Agilibox::FormHelper, type: :helper do
  describe "#form_buttons" do
    it "should include back link and submit button" do
      html = form_buttons
      expect(html).to include "form-submit"
      expect(html).to include "form-cancel"
    end

    it "should not return full url" do
      html = form_buttons(back_url: "http://example.org/abc")
      expect(html).to include "/abc"
      expect(html).to_not include "://"
    end

    it "should hide back button if back_url is false" do
      html = form_buttons(back_url: false)
      expect(html).to_not include "form-cancel"
    end
  end # describe "#form_buttons"
end
