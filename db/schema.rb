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

ActiveRecord::Schema.define(version: 20160914233527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "jig_order_line_items", force: :cascade do |t|
    t.integer  "repaired"
    t.integer  "cleaned"
    t.integer  "jig_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "jig_order_id"
  end

  add_index "jig_order_line_items", ["jig_id"], name: "index_jig_order_line_items_on_jig_id", using: :btree
  add_index "jig_order_line_items", ["jig_order_id"], name: "index_jig_order_line_items_on_jig_order_id", using: :btree

  create_table "jig_orders", force: :cascade do |t|
    t.date     "date"
    t.integer  "customer_id"
    t.text     "notes"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "jig_order_line_item_id"
    t.integer  "report_id"
  end

  add_index "jig_orders", ["customer_id"], name: "index_jig_orders_on_customer_id", using: :btree
  add_index "jig_orders", ["jig_order_line_item_id"], name: "index_jig_orders_on_jig_order_line_item_id", using: :btree
  add_index "jig_orders", ["report_id"], name: "index_jig_orders_on_report_id", using: :btree

  create_table "jigs", force: :cascade do |t|
    t.string   "name"
    t.float    "cleaning_charge"
    t.float    "repair_charge"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image"
    t.integer  "customer_id"
    t.integer  "jig_order_line_item_id"
  end

  add_index "jigs", ["customer_id"], name: "index_jigs_on_customer_id", using: :btree
  add_index "jigs", ["jig_order_line_item_id"], name: "index_jigs_on_jig_order_line_item_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.float    "delivery_charge"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "customer_id"
  end

  add_index "reports", ["customer_id"], name: "index_reports_on_customer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "jig_orders", "reports"
  add_foreign_key "reports", "customers"
end
