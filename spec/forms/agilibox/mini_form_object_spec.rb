require "rails_helper"

describe Agilibox::MiniFormObject do
  class DummyModelToTestFormObject < ::DummyModel
    validates :string_field, presence: true
  end

  class DummyFormToTestFormObject < described_class
    validates :integer_field, presence: true
  end

  let(:model_instance) { DummyModelToTestFormObject.new }
  let(:form_instance) { DummyFormToTestFormObject.new(model_instance) }

  it "#valid? should be true when both model and form validations are ok" do
    expect(model_instance.valid?).to eq false
    expect(form_instance.valid?).to  eq false

    model_instance.string_field = "abc"

    expect(model_instance.valid?).to eq true
    expect(form_instance.valid?).to  eq false

    model_instance.integer_field = 123

    expect(model_instance.valid?).to eq true
    expect(form_instance.valid?).to  eq true
  end

  it "#validate should be an alias of #valid?" do
    valid_method    = described_class.instance_method(:valid?)
    validate_method = described_class.instance_method(:validate)

    expect(validate_method).to eq valid_method
  end

  it "#invalid? should be true when any of model or form validations are not ok" do
    expect(model_instance.invalid?).to eq true
    expect(form_instance.invalid?).to  eq true

    model_instance.string_field = "abc"

    expect(model_instance.invalid?).to eq false
    expect(form_instance.invalid?).to  eq true

    model_instance.integer_field = 123

    expect(model_instance.invalid?).to eq false
    expect(form_instance.invalid?).to  eq false
  end

  it "#validate! should raise when any of model or form validations are not ok" do
    expect { model_instance.validate! }.to raise_error(ActiveRecord::RecordInvalid)
    expect { form_instance.validate! }.to raise_error(ActiveModel::ValidationError)

    model_instance.string_field = "abc"

    expect { model_instance.validate! }.to_not raise_error
    expect { form_instance.validate! }.to raise_error(ActiveModel::ValidationError)

    model_instance.integer_field = 123

    expect { model_instance.validate! }.to_not raise_error
    expect { form_instance.validate! }.to_not raise_error
  end

  it "#save should persist data only when both model and form validations are ok" do
    expect(form_instance.save).to eq false
    expect(model_instance).to_not be_persisted

    model_instance.string_field = "abc"

    expect(form_instance.save).to eq false
    expect(model_instance).to_not be_persisted

    model_instance.integer_field = 123

    expect(form_instance.save).to eq true
    expect(model_instance).to be_persisted
  end

  it "#save! should raise when any of model or form validations are not ok" do
    expect { form_instance.save! }.to raise_error(ActiveModel::ValidationError)
    expect(model_instance).to_not be_persisted

    model_instance.string_field = "abc"

    expect { form_instance.save! }.to raise_error(ActiveModel::ValidationError)
    expect(model_instance).to_not be_persisted

    model_instance.integer_field = 123

    expect { form_instance.save! }.to_not raise_error
    expect(model_instance).to be_persisted
  end

  it "should merge errors into object errors" do
    model_instance.valid?
    expect(model_instance.errors.keys).to eq [:string_field]

    form_instance.valid?
    expect(model_instance.errors.keys).to eq [:string_field, :integer_field]
    expect(form_instance.errors.keys).to  eq [:string_field, :integer_field]
  end

  it "should auto delegate methods to object" do
    model_instance.string_field = "yo"
    expect(form_instance.string_field).to eq "yo"
  end
end
