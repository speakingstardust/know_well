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

ActiveRecord::Schema.define(version: 20170222154053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

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
  end

  add_index "jig_orders", ["customer_id"], name: "index_jig_orders_on_customer_id", using: :btree
  add_index "jig_orders", ["jig_order_line_item_id"], name: "index_jig_orders_on_jig_order_line_item_id", using: :btree

  create_table "jig_orders_reports", id: false, force: :cascade do |t|
    t.integer "jig_order_id", null: false
    t.integer "report_id",    null: false
  end

  add_index "jig_orders_reports", ["jig_order_id", "report_id"], name: "index_jig_orders_reports_on_jig_order_id_and_report_id", using: :btree
  add_index "jig_orders_reports", ["report_id", "jig_order_id"], name: "index_jig_orders_reports_on_report_id_and_jig_order_id", using: :btree

  create_table "jigs", force: :cascade do |t|
    t.string   "name"
    t.float    "cleaning_charge"
    t.float    "repair_charge"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "customer_id"
    t.integer  "jig_order_line_item_id"
    t.string   "jig_photo_file_name"
    t.string   "jig_photo_content_type"
    t.integer  "jig_photo_file_size"
    t.datetime "jig_photo_updated_at"
  end

  add_index "jigs", ["customer_id"], name: "index_jigs_on_customer_id", using: :btree
  add_index "jigs", ["jig_order_line_item_id"], name: "index_jigs_on_jig_order_line_item_id", using: :btree

  create_table "report_line_items", force: :cascade do |t|
    t.integer  "subtotal_cleaned"
    t.integer  "subtotal_repaired"
    t.float    "cleaning_charge_subtotal"
    t.float    "repair_charge_subtotal"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "report_id"
    t.integer  "jig_id"
  end

  add_index "report_line_items", ["jig_id"], name: "index_report_line_items_on_jig_id", using: :btree
  add_index "report_line_items", ["report_id"], name: "index_report_line_items_on_report_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.date     "date_from"
    t.date     "date_to"
    t.integer  "total_cleaned"
    t.integer  "total_repaired"
    t.float    "cleaning_charge_total"
    t.float    "repair_charge_total"
    t.float    "charges_subtotal"
    t.float    "delivery_charge"
    t.float    "grand_total"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "customer_id"
  end

  add_index "reports", ["customer_id"], name: "index_reports_on_customer_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
