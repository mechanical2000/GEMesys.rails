require "rails_helper"

RSpec.describe Agilibox::ModelI18n, type: :model do
  it "should translate model name on class" do
    expect(DummyModel.t).to eq "Mon model"
    expect(DummyModel.ts).to eq "Mes models"
  end

  it "should translate model name on instances" do
    expect(DummyModel.new.t).to eq "Mon model"
    expect(DummyModel.new.ts).to eq "Mes models"
  end

  it "should translate attributes on class" do
    expect(DummyModel.t :name).to eq "Nom"
  end

  it "should translate attributes on instances" do
    expect(DummyModel.new.t :name).to eq "Nom"
  end
end
