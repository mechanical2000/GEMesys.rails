require "rails_helper"

describe Agilibox::SortingHelper, type: :helper do
  before do
    Rails.application.routes.draw { resources :anonymous }
  end

  after do
    Rails.application.reload_routes!
  end

  describe "#sortable_column" do
    let(:params) {
      {
        :controller => "anonymous",
        :action     => "index",
      }
    }

    it "current sort is nil" do
      link = sortable_column("text", :col)
      expect(link).to eq %(<a class="sort" href="/anonymous?sort=col">text</a>)
    end

    it "current sort is col" do
      params[:sort] = "col"
      link = sortable_column("text", :col)
      expect(link).to eq %(<a class="sort asc" href="/anonymous?sort=-col">text ↓</a>)
    end

    it "current sort is -col" do
      params[:sort] = "-col"
      link = sortable_column("text", :col)
      expect(link).to eq %(<a class="sort desc" href="/anonymous?sort=col">text ↑</a>)
    end

    it "current sort is other" do
      params[:sort] = "other"
      link = sortable_column("text", :col)
      expect(link).to eq %(<a class="sort" href="/anonymous?sort=col">text</a>)
    end

    it "current sort is -other" do
      params[:sort] = "-other"
      link = sortable_column("text", :col)
      expect(link).to eq %(<a class="sort" href="/anonymous?sort=col">text</a>)
    end

    it "should keep other params" do
      params[:q]    = "q"
      params[:sort] = "col"
      link = sortable_column("text", :col)
      expect(link).to eq %(<a class="sort asc" href="/anonymous?q=q&amp;sort=-col">text ↓</a>)
    end

    it "should raise on invalid column type" do
      # old handles_sortable_columns syntax
      expect {
        sortable_column("text", column: "col")
      }.to raise_error ArgumentError
    end

    it "should allow customer :url_params" do
      params.clear
      link = sortable_column("text", :col, url_params: {controller: :anonymous, action: :index})
      expect(link).to eq %(<a class="sort" href="/anonymous?sort=col">text</a>)
    end

    it "should allow link_to attributes" do
      link = sortable_column("text", :col, remote: true)
      expect(link).to eq %(<a class="sort" data-remote="true" href="/anonymous?sort=col">text</a>)
    end
  end # describe "#sortable_column"

  describe "#sortable_column_order" do
    attr_reader :params

    it "should parse asc column" do
      @params = {sort: "col"}
      expect(sortable_column_order).to eq [:col, :asc]
    end

    it "should parse desc column" do
      @params = {sort: "-col"}
      expect(sortable_column_order).to eq [:col, :desc]
    end

    it "should parse nil" do
      @params = {}
      expect(sortable_column_order).to eq [nil, nil]
    end

    it "should accept block" do
      @params = {sort: "-col"}

      sortable_column_order do |column, direction|
        expect(column).to eq :col
        expect(direction).to eq :desc
      end
    end

    it "should accept sort argument" do
      column, direction = sortable_column_order("-col")
      expect(column).to eq :col
      expect(direction).to eq :desc
    end
  end # describe "#sortable_column_order"
end
