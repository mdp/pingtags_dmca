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

  create_table "links", :force => true do |t|
    t.string   "destination"
    t.string   "type"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
  end
  
  create_table "contact", :force => true do |t|
    t.string  "phone_office"
    t.string  "phone_mobile"
    t.string  "phone_fax"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "country"
    t.string  "postal_code"
    t.string  "company"
    t.string  "url"
    t.integer "user_id"
  end

  create_table "mobile_sessions" do |t|
    t.string  "cookie"
    t.string  "user_agent"
    t.integer "contact_id"
    t.timestamps
  end
  
  create_table 'actions' do |t|
    t.integer "mobile_session_id"
    t.string "description"
    t.timestamps
  end

end
