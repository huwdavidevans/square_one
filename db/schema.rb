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

ActiveRecord::Schema.define(:version => 20120706143721) do

  create_table "user_roles", :force => true do |t|
    t.string "title",       :limit => 25
    t.string "description", :limit => 50
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",  :limit => 50,                 :null => false
    t.string   "last_name",   :limit => 50,                 :null => false
    t.string   "user_name",   :limit => 25,                 :null => false
    t.string   "screen_name", :limit => 50
    t.string   "email",       :limit => 100,                :null => false
    t.string   "title",       :limit => 50
    t.text     "description"
    t.integer  "user_level",                 :default => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

end
