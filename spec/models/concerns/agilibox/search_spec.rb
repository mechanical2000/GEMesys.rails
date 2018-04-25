require "rails_helper"

describe Agilibox::Search do
  it "should search" do
    jean = DummyModel.create!(string_field: "Jean DUPONT")
    jane = DummyModel.create!(string_field: "Jane DURAND")

    results = DummyModel.search("jean")
    expect(results).to eq [jean]
  end

  it "results should have all keywords" do
    jean = DummyModel.create!(string_field: "Jean DUPONT")
    jane = DummyModel.create!(string_field: "Jane DURAND")

    results = DummyModel.search("jean dupont")

    expect(results).to eq [jean]
  end

  it "should ignore accents" do
    e1 = DummyModel.create!(string_field: "aeroport")
    e2 = DummyModel.create!(string_field: "aéroport")
    r1 = DummyModel.search("aeroport", :string_field)
    r2 = DummyModel.search("aéroport", :string_field)

    expect(r1).to include e1
    expect(r1).to include e2
    expect(r2).to include e1
    expect(r2).to include e2
  end

  it "default_search_fields should return string and text fields only" do
    expect(DummyModel.default_search_fields.sort).to eq %w(
      dummy_models.asso_type
      dummy_models.string_field
      dummy_models.text_field
    )
  end
end
