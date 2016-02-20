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

ActiveRecord::Schema.define(version: 20160220162123) do

  create_table "cabs", force: :cascade do |t|
    t.string  "cab_type"
    t.integer "location_x"
    t.integer "location_y"
    t.string  "status"
    t.integer "customer_id"
  end

  add_index "cabs", ["customer_id"], name: "index_cabs_on_customer_id"

  create_table "customers", force: :cascade do |t|
    t.string  "name"
    t.integer "location_x"
    t.integer "location_y"
    t.integer "destination_x"
    t.integer "destination_y"
    t.string  "request_type"
    t.integer "cab_no"
  end

end
