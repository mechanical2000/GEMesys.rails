require "rails_helper"

describe Agilibox::CollectionUpdate do
  let(:model) {
    Class.new(DummyModel) do
      def self.model_name
        ActiveModel::Name.new(self, nil, "TmpDummyModel")
      end

      validates :string_field, presence: true
    end
  }

  let(:uuid1) { Agilibox::SortableUUIDGenerator.call }
  let(:uuid2) { Agilibox::SortableUUIDGenerator.call }

  let!(:instance1) { model.create!(id: uuid1, string_field: "A") }
  let!(:instance2) { model.create!(id: uuid2, string_field: "B") }

  def updater_for(arr)
    described_class.new(model.all, arr)
  end

  it "#update should update objects and return true" do
    service = updater_for [
      {id: uuid1, string_field: "X"},
      {id: uuid2, string_field: "Y"},
    ]

    expect(service.update).to eq true
    expect(instance1.reload.string_field).to eq "X"
    expect(instance2.reload.string_field).to eq "Y"
  end

  it "#update should NOT update any objects and return false in any object is invalid" do
    service = updater_for [
      {id: uuid1, string_field: ""},
      {id: uuid2, string_field: "Y"},
    ]

    expect(service.update).to eq false
    expect(instance1.reload.string_field).to eq "A"
    expect(instance2.reload.string_field).to eq "B"
  end

  it "#update should destroy objects width _destroy=1" do
    service = updater_for [
      {id: uuid1, _destroy: 0},
      {id: uuid2, _destroy: 1},
    ]

    expect(service.update).to eq true
    expect { instance1.reload }.to_not raise_error
    expect { instance2.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "#update! should raise exception on invalid record" do
    service = updater_for [
      {id: uuid1, string_field: ""},
      {id: uuid2, string_field: "Y"},
    ]

    expect { service.update! }.to raise_error(ActiveRecord::RecordInvalid)

    expect(instance1.reload.string_field).to eq "A"
    expect(instance2.reload.string_field).to eq "B"
  end
end
