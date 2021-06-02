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

ActiveRecord::Schema.define(version: 2021_05_29_032252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # These are custom enum types that must be created before they can be used in the schema definition
  create_enum "status_type", ["success", "error"]

  create_table "domains", force: :cascade do |t|
    t.string "hostname", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["hostname"], name: "index_domains_on_hostname", unique: true
  end

  create_table "statuses", force: :cascade do |t|
    t.string "hostname", null: false
    t.enum "status_type", null: false, as: "status_type"
    t.string "message", null: false
    t.boolean "current", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["current"], name: "index_statuses_on_current"
    t.index ["hostname"], name: "index_statuses_on_hostname", unique: true, where: "(current IS TRUE)"
  end

end
