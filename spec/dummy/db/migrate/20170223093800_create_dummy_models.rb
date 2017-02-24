class CreateDummyModels < ActiveRecord::Migration[5.0]
  def change
    create_table :dummy_models do |t|
      t.string   :string_field
      t.text     :text_field
      t.integer  :integer_field
      t.decimal  :decimal_field
      t.boolean  :boolean_field
      t.date     :date_field
      t.datetime :datetime_field
      t.integer  :asso_id
      t.string   :asso_type
      t.timestamps
    end
  end
end
