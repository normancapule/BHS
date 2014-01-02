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

ActiveRecord::Schema.define(:version => 20140102112251) do

  create_table "accounts", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "nickname"
    t.integer  "cellphone"
    t.text     "address"
    t.date     "birthday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role_id"
  end

  create_table "data_streams", :force => true do |t|
    t.integer  "client_count"
    t.date     "stream_date"
    t.decimal  "gross",        :precision => 8, :scale => 2
    t.decimal  "net",          :precision => 8, :scale => 2
    t.decimal  "expenses",     :precision => 8, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "account_id"
    t.integer  "card_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "member_type"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "number_people"
    t.datetime "datetime"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.integer  "service_type_id"
    t.float    "member_price_morn", :default => 0.0
    t.float    "member_price_eve",  :default => 0.0
    t.float    "regular_price",     :default => 0.0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "mytype",            :default => "service"
    t.integer  "service_id"
  end

  add_index "services", ["service_id"], :name => "index_services_on_service_id"

  create_table "transaction_details", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "service_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "customer_id"
    t.float    "total_price",      :default => 0.0
    t.integer  "therapist_id"
    t.text     "notes"
    t.boolean  "paid",             :default => false
    t.integer  "transaction_type"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.date     "transac_date"
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
    t.string   "authentication_token"
    t.integer  "account_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
