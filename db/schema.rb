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

ActiveRecord::Schema[7.0].define(version: 2022_07_12_140445) do
  create_table "govs", force: :cascade do |t|
    t.string "gov_id_type", default: "ID", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gov_id_type"], name: "index_govs_on_gov_id_type", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "gov_id_number", null: false
    t.integer "gov_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "gov_id_number"], name: "index_users_on_email_and_gov_id_number", unique: true
    t.index ["first_name", "last_name", "email", "gov_id_number"], name: "index_unique_all_fields", unique: true
    t.index ["gov_id"], name: "index_users_on_gov_id"
  end

  add_foreign_key "users", "govs"
end
