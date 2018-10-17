require "rails_helper"

describe Agilibox::DefaultValuesConcern do
  let(:model) {
    Class.new(DummyModel) do
      def assign_default_values
        assign_default :string_field, "yo"
      end
    end
  }

  it "should assign default values on build" do
    instance = model.new
    expect(instance.string_field).to eq "yo"
  end

  it "should not override attributes" do
    instance = model.new(string_field: "hey")
    expect(instance.string_field).to eq "hey"
  end

  it "should not be called on find" do
    instance = model.create!
    instance.update_columns(string_field: nil)
    instance = model.find(instance.id)
    expect(instance.string_field).to eq nil
  end
end
