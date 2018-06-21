require "rails_helper"

describe Agilibox::ApiControllerConcern, type: :controller do
  controller(::ApplicationController) do
    include Agilibox::ApiControllerConcern

    def index
    end
  end

  def action(&block)
    controller.define_singleton_method(:index, &block)
    get :index
  end

  it "allow to call #render_json without argument" do
    action { render_json }
    expect(response).to be_ok
    expect(json_response).to eq("current_user" => nil)
  end

  it "allow to call #render_json with json" do
    action { render_json(data: :val) }
    expect(response).to be_ok
    expect(json_response).to eq("current_user" => nil, "data" => "val")
  end

  it "allow to call #render_json with options" do
    action { render_json({}, {status: :not_found}) }
    expect(response).to be_not_found
  end

  it "should call serializer with current_user in both data and options" do
    expect(Agilibox::MiniModelSerializer::Serialize).to receive(:call)
      .with({current_user: nil}, {current_user: nil})
      .and_call_original
      .ordered

    expect(Agilibox::MiniModelSerializer::Serialize).to receive(:call)
      .and_call_original
      .at_least(:once)
      .ordered

    action { render_json }
  end

  it "should pass data and options to serializer" do
    expect(Agilibox::MiniModelSerializer::Serialize).to receive(:call)
      .with({data: :val, current_user: nil}, {opt: :val, current_user: nil})
      .and_call_original
      .ordered

    expect(Agilibox::MiniModelSerializer::Serialize).to receive(:call)
      .and_call_original
      .at_least(:once)
      .ordered

    action { render_json({data: :val}, {opt: :val}) }
  end

  it "should render not found" do
    action { render_not_found }
    expect(response).to be_not_found
    expect(json_response).to eq(
      "current_user" => nil,
      "error"        => "Page demandée non trouvée",
    )
  end

  it "should render forbiddden" do
    action { render_forbidden }
    expect(response).to be_forbidden
    expect(json_response).to eq(
      "current_user" => nil,
      "error"        => "Vous devez être connecté pour accéder à cette page",
    )
  end

  it "should render unauthorized" do
    action { render_unauthorized }
    expect(response).to be_unauthorized
    expect(json_response).to eq(
      "current_user" => nil,
      "error"        => "Vous n'êtes pas authorisé à accéder à cette page",
    )
  end

  it "should render forbiddden if not logged in" do
    allow(controller).to receive(:current_user).and_return(nil)
    action { render_forbidden_or_unauthorized }
    expect(response).to be_forbidden
  end

  it "should render unauthorized if logged in" do
    allow(controller).to receive(:current_user).and_return("user")
    action { render_forbidden_or_unauthorized }
    expect(response).to be_unauthorized
  end

  it "should render error with default status" do
    action { render_json_error "my_err" }
    expect(response.status).to eq 422
  end

  it "should render error with custom status" do
    action { render_json_error "my_err", status: :internal_server_error }
    expect(response.status).to eq 500
  end

  it "should render error with object" do
    expect(controller).to receive(:json_error_string_for_model) \
      .with(instance_of(DummyModel)).at_least(:once).and_return("aaa")

    expect(controller).to receive(:json_errors_hash_for_model) \
      .with(instance_of(DummyModel)).at_least(:once).and_return("bbb")

    action {
      render_json_error DummyModel.new
    }

    expect(response.status).to eq 422
    expect(json_response).to eq(
      "current_user" => nil,
      "error"        => "aaa",
      "model_errors" => "bbb",
    )
  end

  it "json_errors_hash_for_model should return errors and keep only first error of each attr" do
    action {
      dummy = DummyModel.new
      dummy.errors.add(:base, "my model error")
      dummy.errors.add(:string_field, :blank)
      dummy.errors.add(:string_field, :invalid)
      render_json json_errors_hash_for_model(dummy)
    }

    expect(json_response).to eq(
      "current_user" => nil,
      "base" => {
        "message"     => "my model error",
        "full_message"=> "my model error",
      },
      "string_field" => {
        "message"      => "doit être rempli(e)",
        "full_message" => "String field doit être rempli(e)",
      },
    )
  end

  it "json_error_string_for_model should return errors and keep only first error of each attr" do
    action {
      dummy = DummyModel.new
      dummy.errors.add(:base, "my model error")
      dummy.errors.add(:string_field, :blank)
      dummy.errors.add(:string_field, :invalid)
      render_json error: json_error_string_for_model(dummy)
    }

    expect(json_response).to eq(
      "current_user" => nil,
      "error"        => "my model error, String field doit être rempli(e)",
    )
  end

  it "should render error with json" do
    action { render_json_error custom_error_key: "my custom error" }
    expect(response.status).to eq 422
    expect(json_response).to eq(
      "current_user"     => nil,
      "custom_error_key" => "my custom error",
    )
  end

  it "should render for found on ActiveRecord not found error" do
    action { DummyModel.find(123_456_789) }
    expect(json_response).to eq(
      "current_user" => nil,
      "error"        => "Page demandée non trouvée",
    )
  end
end
