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

ActiveRecord::Schema.define(:version => 20120727123918) do

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "deadline"
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id", :null => false
    t.integer "user_id",    :null => false
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id"

  create_table "tasks", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.date     "deadline"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "complete",     :default => false
    t.integer  "work_minutes", :default => 438
  end

  create_table "todo_lists", :force => true do |t|
    t.integer  "task_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "todos", :force => true do |t|
    t.integer  "todo_list_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "complete"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.string "title",       :limit => 25
    t.string "description", :limit => 50
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 50,                     :null => false
    t.string   "last_name",           :limit => 50,                     :null => false
    t.string   "username",            :limit => 25,                     :null => false
    t.string   "screen_name",         :limit => 50
    t.string   "email",               :limit => 100,                    :null => false
    t.string   "title",               :limit => 50
    t.text     "description"
    t.integer  "level",                              :default => 0
    t.boolean  "active",                             :default => false
    t.string   "password",                                              :null => false
    t.string   "salt",                                                  :null => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
