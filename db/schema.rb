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

ActiveRecord::Schema.define(version: 20170508165042) do

  create_table "admins", force: :cascade do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 64
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string   "holder_name",      limit: 120, null: false
    t.string   "number",           limit: 4,   null: false
    t.integer  "expiration_month",             null: false
    t.integer  "expiration_year",              null: false
    t.string   "brand",            limit: 75,  null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "class_dates", force: :cascade do |t|
    t.integer  "event_id",      null: false
    t.integer  "instructor_id"
    t.integer  "location_id",   null: false
    t.datetime "date"
    t.string   "room"
    t.integer  "duration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "limit"
    t.integer  "available"
    t.datetime "finish"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",              limit: 75, null: false
    t.text     "description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "name",                limit: 75, null: false
    t.string   "lastname",            limit: 75, null: false
    t.text     "biography"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "address",      null: false
    t.time     "opening_hour", null: false
    t.time     "closing_hour", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.integer  "price",                  null: false
    t.integer  "classes",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "code",           limit: 10, null: false
    t.integer  "promotion_type",            null: false
    t.datetime "expiration",                null: false
    t.integer  "amount",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.integer  "class_date_id"
    t.boolean  "assisted",      default: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "platform",   limit: 1,              null: false
    t.datetime "deleted_at"
    t.integer  "user_id",                           null: false
    t.integer  "api_key_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "device_id",            default: ""
    t.index ["api_key_id"], name: "index_sessions_on_api_key_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "user_packages", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "package_id",   null: false
    t.integer  "promotion_id"
    t.integer  "price",        null: false
    t.integer  "card_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                   limit: 75,                 null: false
    t.string   "lastname",               limit: 75,                 null: false
    t.integer  "available_classes",                 default: 0,     null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "phone",                  limit: 13
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "sex"
    t.date     "birth"
    t.boolean  "admin_permission",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "waiting_lists", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "class_date_id"
  end

end
