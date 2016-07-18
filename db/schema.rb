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

ActiveRecord::Schema.define(version: 20160718141156) do

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "state"
    t.string   "airport_code"
    t.string   "type"
    t.integer  "route_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "airports", ["route_id"], name: "index_airports_on_route_id"

  create_table "bookings", force: :cascade do |t|
    t.string   "reference_number", null: false
    t.integer  "flight_id"
    t.integer  "user_id"
    t.string   "class_level",      null: false
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

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "comment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "flights", force: :cascade do |t|
    t.integer  "stops"
    t.string   "plane_name"
    t.integer  "seats_available"
    t.datetime "date"
    t.integer  "route_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "flights", ["route_id"], name: "index_flights_on_route_id"

  create_table "passengers", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "gender"
    t.string   "age_grade",  null: false
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  add_index "passengers", ["booking_id"], name: "index_passengers_on_booking_id"

  create_table "routes", force: :cascade do |t|
    t.integer  "departing_airport_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "routes", ["departing_airport_id"], name: "index_routes_on_departing_airport_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "phone"
    t.string   "password_digest"
    t.string   "gender"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
