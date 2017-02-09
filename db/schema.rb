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

ActiveRecord::Schema.define(version: 20170209030819) do

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

  create_table "sessions", force: :cascade do |t|
    t.integer  "platform",   limit: 1, null: false
    t.datetime "deleted_at"
    t.integer  "user_id",              null: false
    t.integer  "api_key_id",           null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["api_key_id"], name: "index_sessions_on_api_key_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                   limit: 75,              null: false
    t.string   "lastname",               limit: 75,              null: false
    t.integer  "available_classes"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
