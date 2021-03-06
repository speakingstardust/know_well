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

ActiveRecord::Schema.define(version: 20180108200825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree

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

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_report_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "categories", ["product_report_id"], name: "index_categories_on_product_report_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "creator_name"
    t.string   "subject"
    t.text     "comment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "project_id"
  end

  add_index "comments", ["project_id"], name: "index_comments_on_project_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.integer  "kind"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contacts", ["customer_id"], name: "index_contacts_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "customer_service_email"
    t.string   "website"
    t.string   "invoice_email"
    t.integer  "payment"
    t.boolean  "mail_invoice"
  end

  create_table "dependencies", id: false, force: :cascade do |t|
    t.integer "task_id"
    t.integer "dependent_task_id"
  end

  add_index "dependencies", ["dependent_task_id", "task_id"], name: "index_dependencies_on_dependent_task_id_and_task_id", unique: true, using: :btree
  add_index "dependencies", ["task_id", "dependent_task_id"], name: "index_dependencies_on_task_id_and_dependent_task_id", unique: true, using: :btree

  create_table "document_mail_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.text     "purpose"
    t.datetime "sent_at"
    t.integer  "customer_id"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "document_id"
  end

  add_index "document_mail_logs", ["admin_id"], name: "index_document_mail_logs_on_admin_id", using: :btree
  add_index "document_mail_logs", ["customer_id"], name: "index_document_mail_logs_on_customer_id", using: :btree
  add_index "document_mail_logs", ["document_id"], name: "index_document_mail_logs_on_document_id", using: :btree
  add_index "document_mail_logs", ["user_id"], name: "index_document_mail_logs_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.integer  "category"
    t.string   "version"
    t.date     "date_issued"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "meico_product_id"
    t.boolean  "current_version"
  end

  create_table "expense_reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.date     "date"
    t.float    "amount"
    t.string   "vendor"
    t.integer  "category"
    t.text     "note"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "other_note"
    t.integer  "payment_method"
    t.string   "receipt_file_name"
    t.string   "receipt_content_type"
    t.integer  "receipt_file_size"
    t.datetime "receipt_updated_at"
  end

  add_index "expense_reports", ["admin_id"], name: "index_expense_reports_on_admin_id", using: :btree
  add_index "expense_reports", ["user_id"], name: "index_expense_reports_on_user_id", using: :btree

  create_table "incident_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "recordable"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "jig_work_order_line_items", force: :cascade do |t|
    t.integer  "jig_id"
    t.integer  "jig_work_order_id"
    t.integer  "expected"
    t.integer  "repaired"
    t.integer  "actual"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "received"
  end

  add_index "jig_work_order_line_items", ["jig_id"], name: "index_jig_work_order_line_items_on_jig_id", using: :btree
  add_index "jig_work_order_line_items", ["jig_work_order_id"], name: "index_jig_work_order_line_items_on_jig_work_order_id", using: :btree

  create_table "jig_work_orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "purchase_order"
    t.text     "notes"
    t.date     "returned"
    t.string   "verified_by"
    t.datetime "verified_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "pickup_date"
    t.string   "pickup_time"
    t.string   "aasm_state"
    t.string   "return_time"
    t.datetime "completed_at"
    t.string   "completed_by"
    t.string   "driver"
    t.string   "truck_number"
  end

  add_index "jig_work_orders", ["customer_id"], name: "index_jig_work_orders_on_customer_id", using: :btree

  create_table "jig_work_orders_reports", id: false, force: :cascade do |t|
    t.integer "jig_work_order_id", null: false
    t.integer "report_id",         null: false
  end

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
    t.text     "aka"
    t.text     "note"
  end

  add_index "jigs", ["customer_id"], name: "index_jigs_on_customer_id", using: :btree
  add_index "jigs", ["jig_order_line_item_id"], name: "index_jigs_on_jig_order_line_item_id", using: :btree

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meico_products", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "amount_required"
    t.datetime "ordered_at"
    t.datetime "received_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "order_line_items", ["order_id"], name: "index_order_line_items_on_order_id", using: :btree
  add_index "order_line_items", ["product_id"], name: "index_order_line_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.date     "date_created"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "product_report_line_items", force: :cascade do |t|
    t.integer  "product_report_id"
    t.integer  "product_id"
    t.float    "current_amount"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "product_report_line_items", ["product_id"], name: "index_product_report_line_items_on_product_id", using: :btree
  add_index "product_report_line_items", ["product_report_id"], name: "index_product_report_line_items_on_product_report_id", using: :btree

  create_table "product_reports", force: :cascade do |t|
    t.date     "date_created"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.string   "part_number"
    t.integer  "vendor_id"
    t.text     "description"
    t.string   "container"
    t.string   "unit"
    t.integer  "units_per_container"
    t.float    "price_per_container"
    t.float    "price_per_unit"
    t.float    "maximum_on_hand"
    t.float    "minimum_on_hand"
    t.integer  "lead_time"
    t.float    "current_on_hand"
    t.float    "order_amount"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "category_id"
    t.string   "serial_number"
    t.string   "location"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["manufacturer_id"], name: "index_products_on_manufacturer_id", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", unique: true, using: :btree
  add_index "products", ["part_number"], name: "index_products_on_part_number", using: :btree
  add_index "products", ["vendor_id"], name: "index_products_on_vendor_id", using: :btree

  create_table "progress_notes", force: :cascade do |t|
    t.integer  "project_id"
    t.text     "note"
    t.string   "created_by"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "progress_notes", ["project_id"], name: "index_progress_notes_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "status"
    t.integer  "department"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "admin_id"
    t.text     "why_question"
    t.text     "market_question"
    t.text     "current_situation_question"
    t.text     "problems_question"
    t.text     "outcome_question"
    t.text     "customer_agreed_question"
    t.text     "requirements_question"
    t.text     "must_do_question"
    t.text     "must_not_do_question"
  end

  add_index "projects", ["admin_id"], name: "index_projects_on_admin_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

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

  create_table "safety_data_sheets", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.integer  "product_id"
  end

  add_index "safety_data_sheets", ["product_id"], name: "index_safety_data_sheets_on_product_id", using: :btree

  create_table "scope_of_works", force: :cascade do |t|
    t.string   "name"
    t.date     "date_created"
    t.string   "created_by"
    t.text     "description"
    t.integer  "customer_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "scope_of_works", ["customer_id"], name: "index_scope_of_works_on_customer_id", using: :btree

  create_table "signatures", force: :cascade do |t|
    t.string   "name"
    t.text     "signature"
    t.datetime "signed_on"
    t.integer  "jig_work_order_id"
    t.string   "kind"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "signatures", ["jig_work_order_id"], name: "index_signatures_on_jig_work_order_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "duration"
    t.string   "name"
    t.text     "description"
    t.boolean  "completed"
    t.integer  "user_id"
    t.integer  "percent_complete"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "position"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

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

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories", "product_reports"
  add_foreign_key "contacts", "customers"
  add_foreign_key "document_mail_logs", "admins"
  add_foreign_key "document_mail_logs", "customers"
  add_foreign_key "document_mail_logs", "documents"
  add_foreign_key "document_mail_logs", "users"
  add_foreign_key "documents", "meico_products"
  add_foreign_key "expense_reports", "admins"
  add_foreign_key "expense_reports", "users"
  add_foreign_key "jig_work_order_line_items", "jig_work_orders"
  add_foreign_key "jig_work_order_line_items", "jigs"
  add_foreign_key "jig_work_orders", "customers"
  add_foreign_key "order_line_items", "orders"
  add_foreign_key "order_line_items", "products"
  add_foreign_key "product_report_line_items", "product_reports"
  add_foreign_key "product_report_line_items", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "products", "vendors"
  add_foreign_key "progress_notes", "projects"
  add_foreign_key "projects", "users"
  add_foreign_key "signatures", "jig_work_orders"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
end
