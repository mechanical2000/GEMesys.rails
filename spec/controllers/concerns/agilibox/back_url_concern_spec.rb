require "rails_helper"

describe Agilibox::BackUrlConcern, type: :controller do
  controller(::ApplicationController) do
    include Agilibox::BackUrlConcern

    def index
      redirect_to back_url
    end
  end

  let(:back_url) { controller.send(:back_url) }

  it "should transform obsolute urls to relative urls" do
    get :index, params: {back_url: "https://user:pwd@example.org/test?some=param"}
    expect(back_url).to eq "/test?some=param"
  end
end
