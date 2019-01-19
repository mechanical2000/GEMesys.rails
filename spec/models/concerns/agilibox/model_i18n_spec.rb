require "rails_helper"

describe Agilibox::ModelI18n, type: :model do
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

  it "should translate attribute values on instances" do
    expect(DummyModel.new.tv :state).to eq "Brouillon"

    allow_any_instance_of(DummyModel).to receive(:state).and_return("")
    expect(DummyModel.new.tv :state).to eq nil
  end

  describe "::raise_on_missing_translations" do
    it "should be false by default" do
      expect(described_class.raise_on_missing_translations).to eq false
    end

    ModelToTestI18n = Class.new(ApplicationRecord)

    describe "when false and translation is missing" do
      before do
        allow(described_class).to receive(:raise_on_missing_translations).and_return(false)
      end

      it "::t should not raise error" do
        expect(ModelToTestI18n.t).to eq "Model to test i18n"
      end

      it "::ts should not raise error" do
        expect(ModelToTestI18n.ts).to eq "Model to test i18n"
      end

      it "::t + attribute should not raise error" do
        expect(ModelToTestI18n.t :some_attribute).to eq "Some attribute"
      end
    end # describe "when false"

    describe "when true and translation is missing" do
      before do
        allow(described_class).to receive(:raise_on_missing_translations).and_return(true)
      end

      let(:exception) { Agilibox::ModelI18n::MissingTranslationError }

      it "::t should raise error" do
        expect {
          ModelToTestI18n.t
        }.to raise_error(exception, "translation missing: ModelToTestI18n singular model name")
      end

      it "::ts should raise error" do
        expect {
          ModelToTestI18n.ts
        }.to raise_error(exception, "translation missing: ModelToTestI18n plural model name")
      end

      it "::t + attribute should raise error" do
        expect {
          ModelToTestI18n.t :some_attribute
        }.to raise_error(exception, "translation missing: ModelToTestI18n#some_attribute")
      end
    end # describe "when true"
  end # describe "::raise_on_missing_translations"
end
