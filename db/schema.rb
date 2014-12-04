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

ActiveRecord::Schema.define(version: 20141119084610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "accounts", force: true do |t|
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["owner_id"], name: "index_accounts_on_owner_id", using: :btree

  create_table "applications", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "active",     default: true
    t.string   "identicon"
    t.string   "auth_token"
    t.integer  "owner_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "applications", ["owner_id"], name: "index_applications_on_owner_id", using: :btree

  create_table "applications_users", id: false, force: true do |t|
    t.integer "application_id"
    t.integer "user_id"
  end

  add_index "applications_users", ["application_id", "user_id"], name: "index_applications_users_on_application_id_and_user_id", unique: true, using: :btree
  add_index "applications_users", ["application_id"], name: "index_applications_users_on_application_id", using: :btree
  add_index "applications_users", ["user_id"], name: "index_applications_users_on_user_id", using: :btree

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "provider_username"
    t.string   "provider_token"
    t.string   "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: true do |t|
    t.string   "status"
    t.text     "message"
    t.json     "metadata"
    t.boolean  "alert",          default: false
    t.string   "keywords"
    t.integer  "application_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "events", ["application_id"], name: "index_events_on_application_id", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "searches", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "criteria"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                           null: false
    t.string   "full_name"
    t.string   "github_login"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_in_count",                   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
