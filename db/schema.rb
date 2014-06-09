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

ActiveRecord::Schema.define(version: 20140607082335) do

  create_table "books", force: true do |t|
    t.string   "user_id"
    t.string   "drive_id"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "connections", force: true do |t|
    t.boolean  "approved"
    t.integer  "landlord_id"
    t.integer  "tenant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tenant_email"
  end

  add_index "connections", ["landlord_id"], name: "index_connections_on_landlord_id", using: :btree
  add_index "connections", ["tenant_id"], name: "index_connections_on_tenant_id", using: :btree

  create_table "contracts", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "tenant_id"
    t.integer  "landlord_id"
    t.integer  "property_id"
    t.decimal  "rental_amount", precision: 10, scale: 0
    t.integer  "pay_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.string   "room_no"
    t.text     "notes"
  end

  add_index "contracts", ["landlord_id"], name: "index_contracts_on_landlord_id", using: :btree
  add_index "contracts", ["property_id"], name: "index_contracts_on_property_id", using: :btree
  add_index "contracts", ["tenant_id"], name: "index_contracts_on_tenant_id", using: :btree

  create_table "drive_feedbacks", force: true do |t|
    t.string   "drive_id"
    t.string   "user_id"
    t.float    "score"
    t.text     "feed_msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drive_way_availabilities", force: true do |t|
    t.date     "from"
    t.date     "to"
    t.integer  "drive_way_id"
    t.boolean  "inclusion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drive_way_prices", force: true do |t|
    t.integer  "days"
    t.decimal  "price",        precision: 10, scale: 0
    t.integer  "drive_way_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drive_ways", force: true do |t|
    t.float    "price"
    t.string   "description"
    t.string   "name"
    t.string   "size"
    t.string   "picture"
    t.integer  "drive_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drive_ways", ["drive_id"], name: "index_drive_ways_on_drive_id", using: :btree

  create_table "drives", force: true do |t|
    t.string   "property_type"
    t.string   "name_of_building"
    t.string   "building_number"
    t.string   "description"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.string   "phone"
    t.text     "notes"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "average_score"
  end

  add_index "drives", ["user_id"], name: "index_drives_on_user_id", using: :btree

  create_table "landlords", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city_town"
    t.string   "province_state_county_region"
    t.string   "country"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "vat_number"
    t.string   "paypal_email_id"
    t.string   "bank_account_no"
    t.string   "bank_name"
    t.string   "bank_branch"
    t.string   "currency"
    t.string   "company_name"
    t.text     "company_description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscription_id"
    t.string   "subscription_type"
    t.string   "avatar"
  end

  add_index "landlords", ["subscription_id"], name: "index_landlords_on_subscription_id", using: :btree
  add_index "landlords", ["user_id"], name: "index_landlords_on_user_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "tenant_id"
    t.integer  "landlord_id"
    t.integer  "contract_id"
    t.integer  "property_id"
    t.string   "status"
    t.date     "due_date"
    t.boolean  "late_payment"
    t.date     "date_paid"
    t.string   "reference_no"
    t.string   "payment_method"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",         precision: 10, scale: 0
    t.string   "return_token"
    t.string   "paypal_token"
  end

  add_index "payments", ["contract_id"], name: "index_payments_on_contract_id", using: :btree
  add_index "payments", ["landlord_id"], name: "index_payments_on_landlord_id", using: :btree
  add_index "payments", ["property_id"], name: "index_payments_on_property_id", using: :btree
  add_index "payments", ["tenant_id"], name: "index_payments_on_tenant_id", using: :btree

  create_table "subscription_payments", force: true do |t|
    t.string   "subscription_type"
    t.decimal  "amount",            precision: 10, scale: 0
    t.date     "date_from"
    t.decimal  "date_to",           precision: 10, scale: 0
    t.string   "payment_for"
    t.date     "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscription_id"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "subscription_type"
    t.date     "date_from"
    t.date     "date_to"
    t.integer  "landlord_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_status"
    t.string   "return_token"
  end

  add_index "subscriptions", ["landlord_id"], name: "index_subscriptions_on_landlord_id", using: :btree

  create_table "tenants", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "sex"
    t.date     "dob"
    t.string   "primary_email"
    t.string   "secondary_email"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "tenants", ["user_id"], name: "index_tenants_on_user_id", using: :btree

  create_table "user_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "address1"
    t.string   "address2"
    t.date     "birthday"
    t.string   "gender"
    t.string   "zipcode"
    t.string   "picture"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
