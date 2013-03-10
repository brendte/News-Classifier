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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130310171108) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "publish_date"
    t.boolean  "like"
    t.boolean  "indexed"
    t.float    "euclidean_length"
  end

  create_table "feed_entries", :force => true do |t|
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.boolean  "fetched"
  end

  create_table "feeds", :force => true do |t|
    t.string   "feed_url"
    t.string   "etag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.boolean  "indexed"
    t.float    "euclidean_length"
  end

  create_table "user_nbs", :force => true do |t|
    t.string   "user"
    t.binary   "nb_obj"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_articles", :force => true do |t|
    t.integer "user_id"
    t.integer "article_id"
  end

end
