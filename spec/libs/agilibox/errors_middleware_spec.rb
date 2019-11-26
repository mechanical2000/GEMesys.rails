require "rails_helper"

xdescribe Agilibox::ErrorsMiddleware, type: :request do
  after do
    ActiveRecord::Base.establish_connection
  end

  it "should intercept invalid format errors" do
    get "/tests/dummy_models.xml"
    expect(response.status).to eq 406
    expect(response.body).to eq "Not acceptable."
  end

  it "should intercept unknown http method errors" do
    integration_session.__send__ :process, "INVALID", "/"
    expect(response.status).to eq 406
    expect(response.body).to eq "Not acceptable."
  end

  xit "should intercept pg errors" do
    ApplicationRecord.establish_connection(adapter: "postgresql", host: "invalid")
    get "/tests/dummy_models"
    expect(response.status).to eq 503
    expect(response.body).to eq "Maintenance en cours."
  end
end
