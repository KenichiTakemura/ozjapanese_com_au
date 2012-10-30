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

ActiveRecord::Schema.define(:version => 20121028032450) do

  create_table "comments", :force => true do |t|
    t.string   "status",                           :null => false
    t.string   "locale"
    t.text     "body"
    t.integer  "abuse",             :default => 0
    t.integer  "likes",             :default => 0
    t.integer  "dislikes",          :default => 0
    t.integer  "number",            :default => 0
    t.integer  "commented_id"
    t.string   "commented_type"
    t.integer  "commented_by_id"
    t.string   "commented_by_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "contacts", :force => true do |t|
    t.integer  "contacted_by_id"
    t.string   "contacted_by_type"
    t.integer  "contact_type"
    t.text     "body"
    t.string   "user_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "contents", :force => true do |t|
    t.text     "body",           :limit => 16777215
    t.integer  "contented_id"
    t.string   "contented_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "daily_hits", :force => true do |t|
    t.datetime "day",                       :null => false
    t.integer  "hit",        :default => 0, :null => false
    t.integer  "user_hit",   :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "flyers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "flyer_name"
    t.string   "flyer_image"
    t.string   "flyer_url"
    t.datetime "agreed_on"
    t.string   "agree_token"
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

  create_table "oz_buy_goods", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_buy_goods", ["z_index"], :name => "index_oz_buy_goods_on_z_index"

  create_table "oz_employers", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_employers", ["z_index"], :name => "index_oz_employers_on_z_index"

  create_table "oz_employments", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_employments", ["z_index"], :name => "index_oz_employments_on_z_index"

  create_table "oz_estate_share_rents", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_estate_share_rents", ["z_index"], :name => "index_oz_estate_share_rents_on_z_index"

  create_table "oz_info_events", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_info_events", ["z_index"], :name => "index_oz_info_events_on_z_index"

  create_table "oz_info_living_qnas", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_info_living_qnas", ["z_index"], :name => "index_oz_info_living_qnas_on_z_index"

  create_table "oz_info_living_smarts", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_info_living_smarts", ["z_index"], :name => "index_oz_info_living_smarts_on_z_index"

  create_table "oz_people_pros", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_people_pros", ["z_index"], :name => "index_oz_people_pros_on_z_index"

  create_table "oz_sell_goods", :force => true do |t|
    t.string   "locale",                                  :null => false
    t.integer  "posted_by_id"
    t.string   "posted_by_type"
    t.integer  "post_updated_by_id"
    t.string   "post_updated_by_type"
    t.string   "requested_by"
    t.integer  "category",                                :null => false
    t.string   "subject",                                 :null => false
    t.datetime "valid_until",                             :null => false
    t.integer  "views",                :default => 0
    t.integer  "status",                                  :null => false
    t.integer  "z_index",              :default => 0
    t.integer  "write_at"
    t.integer  "mode"
    t.boolean  "has_image",            :default => false
    t.boolean  "has_attachment",       :default => false
    t.boolean  "sns_feeded",           :default => false
    t.string   "sns_provider"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "oz_sell_goods", ["z_index"], :name => "index_oz_sell_goods_on_z_index"

  create_table "roles", :force => true do |t|
    t.string   "role_name"
    t.integer  "role_value"
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "terms", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "top_feed_lists", :force => true do |t|
    t.integer  "feeded_to_id"
    t.string   "feeded_to_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
