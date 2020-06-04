# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2017_02_23_093800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "dummy_models", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "string_field"
    t.text "text_field"
    t.integer "integer_field"
    t.decimal "decimal_field"
    t.boolean "boolean_field"
    t.date "date_field"
    t.datetime "datetime_field"
    t.uuid "asso_id"
    t.string "asso_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
