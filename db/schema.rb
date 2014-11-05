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

ActiveRecord::Schema.define(version: 20141015115159) do

  create_table "categories", force: true do |t|
    t.string   "category_id",   null: false
    t.string   "category_name", null: false
    t.string   "product_type",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "product_id",    null: false
    t.string   "product_name",  null: false
    t.string   "product_price", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "fname",                       null: false
    t.string   "mname"
    t.string   "lname",                       null: false
    t.string   "email",                       null: false
    t.string   "password",                    null: false
    t.date     "dob",                         null: false
    t.string   "gender",                      null: false
    t.text     "address",                     null: false
    t.string   "phone",                       null: false
    t.string   "user_type",  default: "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
