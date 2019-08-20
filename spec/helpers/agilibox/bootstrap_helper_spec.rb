require "rails_helper"

describe Agilibox::BootstrapHelper do
  def asset_html_eq(a, b)
    a = a.split("\n").map(&:strip).join
    b = b.split("\n").map(&:strip).join
    expect(a).to eq b
  end

  before do
    described_class.card_classes = nil
  end

  describe "#bs_progress_bar" do
    it "should generate progress bar" do
      html = bs_progress_bar(50)

      asset_html_eq html, %(
        <div class="progress">
          <div class="progress-bar" style="width:50%">50%</div>
        </div>
      )
    end
  end # describe "#bs_progress_bar"

  describe "#bs_card" do
    it "should return card" do
      html = bs_card { "world" }

      asset_html_eq html, %(
        <div class="card">
          <div class="card-body">world</div>
        </div>
      )
    end

    it "should return card with header" do
      html = bs_card(header: "hello") { "world" }

      asset_html_eq html, %(
        <div class="card">
          <div class="card-header">hello</div>
          <div class="card-body">world</div>
        </div>
      )
    end

    it "should return card without body" do
      html = bs_card(body: false) { "world" }

      asset_html_eq html, %(
        <div class="card">
          world
        </div>
      )
    end

    it "should return card with footer" do
      html = bs_card(footer: "foo") { "world" }

      asset_html_eq html, %(
        <div class="card">
          <div class="card-body">world</div>
          <div class="card-footer">foo</div>
        </div>
      )
    end

    it "should allow css classes and custom tags" do
      options = {
        :header       => "header",
        :footer       => "footer",
        :card_tag     => "article",
        :header_tag   => "header",
        :body_tag     => "main",
        :footer_tag   => "footer",
        :card_class   => "a z",
        :header_class => "ah zh",
        :body_class   => "ab zb",
        :footer_class => "af zf",
      }

      html = bs_card(**options) { "body" }

      asset_html_eq html, %(
        <article class="a card z">
          <header class="ah card-header zh">header</header>
          <main class="ab card-body zb">body</main>
          <footer class="af card-footer zf">footer</footer>
        </article>
      )
    end

    it "should allow custom card class" do
      described_class.card_classes = {
        :card   => "panel panel-default",
        :header => "panel-heading panel-title",
        :body   => "panel-body",
        :footer => "panel-footer",
      }

      html = bs_card(header: "header", footer: "footer") { "body" }

      asset_html_eq html, %(
        <div class="panel panel-default">
          <div class="panel-heading panel-title">header</div>
          <div class="panel-body">body</div>
          <div class="panel-footer">footer</div>
        </div>
      )
    end
  end # describe "#bs_card"
end
