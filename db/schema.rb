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

ActiveRecord::Schema.define(:version => 20130915083655) do

  create_table "allotments", :force => true do |t|
    t.integer  "period_id"
    t.string   "allotable_type"
    t.integer  "allotable_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "row_order"
  end

  create_table "attachments", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "boards", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "conference_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "submission_id"
    t.integer  "user_id"
    t.integer  "category"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "conference_users", :force => true do |t|
    t.integer  "conference_id"
    t.string   "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "ticket"
  end

  add_index "conference_users", ["ticket"], :name => "ticket", :unique => true

  create_table "conferences", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.integer  "number_of_days"
    t.string   "venue"
    t.boolean  "active"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "slug"
    t.date     "early_bird_close"
    t.date     "abstract_submission_start"
    t.date     "abstract_submission_close"
    t.date     "workshop_registration_start"
    t.date     "workshop_registration_close"
    t.date     "online_registration_close"
  end

  create_table "details", :force => true do |t|
    t.string   "gender"
    t.date     "dob"
    t.string   "academic"
    t.string   "institute_affiliation"
    t.text     "address"
    t.string   "phone"
    t.string   "nationality"
    t.string   "passport"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "user_id"
  end

  create_table "ideas", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "board_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pagecats", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "active"
    t.integer  "conference_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "pagecat_id"
    t.string   "slug"
  end

  create_table "periods", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "conference_id"
  end

  create_table "plenaries", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "presenter"
    t.integer  "conference_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "slug"
  end

  create_table "reviewer_submissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "schedulable_id"
    t.string   "schedulable_type"
    t.time     "starttime"
    t.integer  "minutes"
    t.string   "venue"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "day"
  end

  create_table "scores", :force => true do |t|
    t.integer  "submission_id"
    t.integer  "user_id"
    t.integer  "conservation"
    t.integer  "science"
    t.integer  "recommendation"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "finalized",      :default => false
  end

  create_table "submissions", :force => true do |t|
    t.string   "title"
    t.text     "authors"
    t.text     "content",       :limit => 2147483647
    t.integer  "conference_id"
    t.integer  "user_id"
    t.integer  "approved"
    t.integer  "preference"
    t.string   "bursary_for"
    t.text     "bursary_why"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "accomodation"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "conference_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "slug"
  end

  add_index "topics", ["slug"], :name => "index_topics_on_slug", :unique => true

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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "role_id",                :default => 3
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workshop_attendees", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "workshop_id"
  end

  create_table "workshops", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "presenter"
    t.string   "conference_id"
    t.string   "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "long"
    t.integer  "seats"
    t.boolean  "repeat"
  end

end
