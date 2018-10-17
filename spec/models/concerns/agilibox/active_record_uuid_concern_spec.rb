require "rails_helper"

describe Agilibox::ActiveRecordUUIDConcern do
  it "should not be present on build" do
    expect(DummyModel.new.id).to be_nil
  end

  it "should not change on saves" do
    obj = DummyModel.create!
    id = obj.id

    obj.update!(string_field: "obj2@example.org")
    expect(obj.id).to eq id

    obj.update!(string_field: "obj3@example.org")
    expect(obj.id).to eq id
  end
end
