# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170223093800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
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
