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

ActiveRecord::Schema.define(version: 20150114165919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "accounts", force: :cascade do |t|
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_accounts_on_owner_id", using: :btree
  end

  create_table "applications", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "active",     default: true
    t.string   "identicon"
    t.string   "auth_token"
    t.integer  "owner_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["owner_id"], name: "index_applications_on_owner_id", using: :btree
  end

  create_table "applications_users", id: false, force: :cascade do |t|
    t.integer "application_id"
    t.integer "user_id"
    t.index ["application_id", "user_id"], name: "index_applications_users_on_application_id_and_user_id", unique: true, using: :btree
    t.index ["application_id"], name: "index_applications_users_on_application_id", using: :btree
    t.index ["user_id"], name: "index_applications_users_on_user_id", using: :btree
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "provider_username"
    t.string   "provider_token"
    t.string   "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "status"
    t.text     "message"
    t.json     "metadata"
    t.boolean  "alert",          default: false
    t.string   "keywords"
    t.integer  "application_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "date"
    t.index ["application_id"], name: "index_events_on_application_id", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "criteria"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_searches_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                           null: false
    t.string   "full_name"
    t.boolean  "admin",                           default: false
    t.integer  "applications_count",              default: 0
    t.integer  "searches_count",                  default: 0
    t.string   "crypted_password",                                null: false
    t.string   "salt",                                            null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_in_count",                   default: 0
    t.index ["activation_token"], name: "index_users_on_activation_token", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end

end
