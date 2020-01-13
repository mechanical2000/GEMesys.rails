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

  it "should intercept PG errors wrapper in AR errors" do
    e = ActiveRecord::StatementInvalid.new("PG::UnableToSend: server closed the connection")
    expect_any_instance_of(TestsController).to receive(:dummy_models).and_raise(e)
    get "/tests/dummy_models"
    expect(response.status).to eq 503
    expect(response.body).to eq "Maintenance en cours."
  end

  it "should not other AR errors" do
    e = ActiveRecord::StatementInvalid.new("some error")
    expect_any_instance_of(TestsController).to receive(:dummy_models).and_raise(e)
    expect { get "/tests/dummy_models" }.to raise_error(e)
  end

  it "should raise on other errors" do
    expect_any_instance_of(TestsController).to receive(:dummy_models).and_raise("err")
    expect { get "/tests/dummy_models" }.to raise_error(RuntimeError)
  end
end
