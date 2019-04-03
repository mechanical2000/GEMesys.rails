require "rails_helper"

describe Agilibox::BootstrapHelper do
  describe "#bs_progress_bar" do
    it "should generate progress bar" do
      html = bs_progress_bar(50)
      expect(html).to eq \
        %(<div class="progress"><div class="progress-bar" style="width:50%">50%</div></div>)
    end
  end # describe "#bs_progress_bar"
end
