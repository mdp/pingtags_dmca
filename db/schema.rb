# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090610021930) do

  create_table "scans", :force => true do |t|
    t.string   "tracking_cookie"
    t.integer  "user_id"
    t.string   "user_agent"
    t.column   "ip_address", 'integer unsigned'
    t.decimal  "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "clicks", :force => true do |t|
    t.integer  "scan_id"
    t.string   "link_href"
    t.string   "link"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "linked_in_id",                      :null => false
    t.string   "access_token"
    t.string   "secret_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "authorized_at"
    t.text     "profile_xml"
    t.boolean  "admin"
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

end
