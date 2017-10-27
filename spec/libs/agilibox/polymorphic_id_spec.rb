require "rails_helper"

RSpec.describe Agilibox::PolymorphicId do
  it "should return guid" do
    obj = DummyModel.create!
    expect(obj.guid).to eq "DummyModel-#{obj.id}"
  end

  it "should return nil if not persisted" do
    obj = DummyModel.new
    expect(obj.guid).to be_nil
  end

  it "should return guid" do
    parent = DummyModel.create!
    child  = DummyModel.create!

    expect(child.asso).to be_nil
    expect(child.asso_id).to be_nil
    expect(child.asso_type).to be_nil

    child.asso_guid = parent.guid

    expect(child.asso).to eq parent
    expect(child.asso_id).to eq parent.id
    expect(child.asso_type).to eq "DummyModel"
  end

  it "should return base_class in guid" do
    OtherDummyModel = Class.new(DummyModel)
    instance = OtherDummyModel.create!
    expect(instance.guid).to eq "DummyModel-#{instance.id}"
  end
end
