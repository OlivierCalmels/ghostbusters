# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_29_204736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "first_table_records", force: :cascade do |t|
    t.integer "emis_number"
    t.string "teacher_surname"
    t.string "teacher_name"
    t.string "teacher_sex"
    t.date "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "junction_records", force: :cascade do |t|
    t.bigint "first_table_record_id", null: false
    t.bigint "second_table_record_id", null: false
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_table_record_id"], name: "index_junction_records_on_first_table_record_id"
    t.index ["second_table_record_id"], name: "index_junction_records_on_second_table_record_id"
  end

  create_table "second_table_records", force: :cascade do |t|
    t.integer "solde_number"
    t.string "surname"
    t.string "name"
    t.date "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "junction_records", "first_table_records"
  add_foreign_key "junction_records", "second_table_records"
end
