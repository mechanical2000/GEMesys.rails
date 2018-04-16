require "rails_helper"

describe Agilibox::Service do
  describe "::initialize_with" do
    it "should set instance variables and attr_reader" do
      service = Class.new(described_class) { initialize_with :email, :password }
      instance = service.new("aaa", "bbb")
      expect(instance.instance_variable_get(:@email)).to eq "aaa"
      expect(instance.instance_variable_get(:@password)).to eq "bbb"
      expect(instance.email).to eq "aaa"
      expect(instance.password).to eq "bbb"
    end

    it "should raise on wrong arguments number" do
      service = Class.new(described_class) { initialize_with :email, :password }
      expect {
        instance = service.new("aaa")
      }.to raise_error(ArgumentError, "wrong number of arguments (given 1, expected 2)")
    end
  end # describe "::initialize_with"

  describe "::call" do
    it "should call #initialize and #call" do
      service = Class.new(described_class) { initialize_with :email }
      expect(service).to receive(:new).with("aaa").and_call_original
      expect_any_instance_of(service).to receive(:call).with(no_args)
      service.call("aaa")
    end
  end # describe "::call"

  describe "#call" do
    it "should raise NotImplementedError" do
      instance = described_class.new
      expect { instance.call }.to raise_error(NotImplementedError)
    end
  end # describe "#call"
end
