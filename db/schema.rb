# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160613144243) do

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "reference_number"
    t.integer  "user_id"
    t.integer  "flight_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "bookings", ["flight_id"], name: "index_bookings_on_flight_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "bookings_users", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bookings_users", ["booking_id"], name: "index_bookings_users_on_booking_id"
  add_index "bookings_users", ["user_id"], name: "index_bookings_users_on_user_id"

  create_table "flights", force: :cascade do |t|
    t.integer  "stops"
    t.string   "plane_name"
    t.integer  "seats"
    t.string   "class_level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "passengers", force: :cascade do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "passengers", ["user_id"], name: "index_passengers_on_user_id"

  create_table "routes", force: :cascade do |t|
    t.string   "departs"
    t.string   "arrives"
    t.datetime "date"
    t.integer  "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "routes", ["flight_id"], name: "index_routes_on_flight_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "type"
    t.integer  "age"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["booking_id"], name: "index_users_on_booking_id"

end
