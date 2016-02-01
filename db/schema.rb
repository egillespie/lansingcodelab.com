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

ActiveRecord::Schema.define(version: 20160130215343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "customer_identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_id",     null: false
    t.json     "stripe_object", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "customer_identities", ["stripe_id"], name: "index_customer_identities_on_stripe_id", using: :btree
  add_index "customer_identities", ["user_id"], name: "index_customer_identities_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "customer_identity_id"
    t.string   "stripe_id",            null: false
    t.json     "stripe_object",        null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "subscriptions", ["customer_identity_id"], name: "index_subscriptions_on_customer_identity_id", using: :btree
  add_index "subscriptions", ["stripe_id"], name: "index_subscriptions_on_stripe_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image_url"
    t.string   "github_url"
    t.string   "username"
    t.text     "github_omniauth_hash"
    t.string   "github_token"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.hstore   "lesson_statuses",      default: {}
    t.json     "projects",             default: {}, null: false
  end

  add_index "users", ["lesson_statuses"], name: "index_users_on_lesson_statuses", using: :gin
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "customer_identities", "users"
  add_foreign_key "subscriptions", "customer_identities"
end
