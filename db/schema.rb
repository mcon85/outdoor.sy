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

ActiveRecord::Schema[7.0].define(version: 2022_04_11_222820) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "vehicle_type", ["bicycle", "campervan", "motorboat", "rv", "sailboat"]

  create_table "vehicles", force: :cascade do |t|
    t.string "customer_full_name", null: false
    t.string "customer_email", null: false
    t.enum "vehicle_type", null: false, enum_type: "vehicle_type"
    t.string "vehicle_name", null: false
    t.integer "vehicle_length", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((customer_email)::text), lower((vehicle_name)::text), vehicle_type", name: "index_vehicles_on_email_and_vehicle_name_and_type", unique: true
    t.index ["customer_full_name"], name: "index_vehicles_on_customer_full_name"
    t.index ["vehicle_type"], name: "index_vehicles_on_vehicle_type"
  end

end
