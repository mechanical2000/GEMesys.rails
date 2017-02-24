require "rails_helper"

RSpec.describe ::Agilibox::SmallData::FiltersController, type: :routing do
  describe "routing" do
    routes { ::Agilibox::Engine.routes }

    it "routes to #create" do
      expect(post "/small_data/filters").to \
      route_to("agilibox/small_data/filters#create")
    end
  end
end
