require "rails_helper"

describe Agilibox::SetupJobConcern do
  let!(:job_class) {
    Class.new(ActiveJob::Base) do # rubocop:disable Rails/ApplicationJob
      include Agilibox::SetupJobConcern
      setup_with :name
    end
  }

  describe "::setup_with" do
    it "should define #setup and attribute readers" do
      instance = job_class.setup("Benoit")
      expect(instance).to be_a job_class
      expect(instance.name).to eq "Benoit"
    end

    it "should raise on invalid arguments" do
      expect {
        job_class.setup("Benoit", 30)
      }.to raise_error(ArgumentError, "wrong number of arguments (given 2, expected 1)")
    end
  end # describe "::setup_with"

  describe "#call" do
    it "should raise not implemented if not overrided" do
      instance = job_class.new
      expect { instance.call }.to raise_error(NotImplementedError)
    end
  end # describe "#call"

  describe "#perform" do
    it "should call #setup and #call" do
      instance = job_class.new
      expect(instance).to receive(:setup).with("Benoit").and_call_original
      expect(instance).to receive(:call)
      instance.perform("Benoit")
    end
  end # describe "#perform"
end
