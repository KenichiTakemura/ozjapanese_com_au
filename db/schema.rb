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

ActiveRecord::Schema.define(:version => 20121022054436) do

  create_table "contents", :force => true do |t|
    t.text     "body",           :limit => 16777215
    t.integer  "contented_id"
    t.string   "contented_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "flyers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "flyer_name"
    t.string   "flyer_image"
    t.string   "flyer_url"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "flyers", ["email"], :name => "index_flyers_on_email", :unique => true
  add_index "flyers", ["reset_password_token"], :name => "index_flyers_on_reset_password_token", :unique => true

  create_table "oz_employments", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.string   "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_employments", ["z_index"], :name => "index_oz_employments_on_z_index"

end
