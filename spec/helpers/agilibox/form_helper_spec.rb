require 'rails_helper'

describe Agilibox::FormHelper, type: :helper do
  describe "form_buttons" do
    it "should not return full url" do
      html = form_buttons(back_url: "http://example.org/abc")
      expect(html).to include "/abc"
      expect(html).to_not include "://"
    end
  end
end
