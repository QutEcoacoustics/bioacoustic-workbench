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

ActiveRecord::Schema.define(:version => 20121031060534) do

  create_table "audio_event_tags", :id => false, :force => true do |t|
    t.integer  "audio_event_id", :null => false
    t.integer  "tag_id",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "audio_events", :force => true do |t|
    t.integer  "audio_recording_id",                      :null => false
    t.decimal  "start_time_seconds",                      :null => false
    t.decimal  "end_time_seconds"
    t.decimal  "low_frequency_hertz",                     :null => false
    t.decimal  "high_frequency_hertz"
    t.boolean  "is_reference",         :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
  end

  add_index "audio_events", ["audio_recording_id"], :name => "index_audio_events_on_audio_recording_id"

  create_table "audio_recordings", :force => true do |t|
    t.string   "uuid",              :limit => 36,  :null => false
    t.integer  "user_id",                          :null => false
    t.datetime "recorded_date",                    :null => false
    t.integer  "site_id",                          :null => false
    t.decimal  "duration_seconds",                 :null => false
    t.integer  "sample_rate_hertz"
    t.integer  "channels"
    t.integer  "bit_rate_bps"
    t.string   "media_type",                       :null => false
    t.integer  "data_length_bytes",                :null => false
    t.string   "hash",              :limit => 524, :null => false
    t.string   "status"
    t.text     "notes"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
  end

  add_index "audio_recordings", ["site_id"], :name => "index_audio_recordings_on_site_id"
  add_index "audio_recordings", ["user_id"], :name => "index_audio_recordings_on_user_id"
  add_index "audio_recordings", ["uuid"], :name => "index_audio_recordings_on_uuid", :unique => true

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "level",               :null => false
    t.integer  "permissionable_id"
    t.string   "permissionable_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "permissions", ["user_id"], :name => "index_permissions_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "uri"
    t.string   "copyright"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.text     "description"
  end

  create_table "project_sites", :id => false, :force => true do |t|
    t.integer  "project_id"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "urn"
    t.text     "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "text"
    t.boolean  "is_taxanomic", :default => false, :null => false
    t.string   "class"
    t.string   "type_of_tag"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
  end

  add_index "tags", ["text"], :name => "index_tags_on_text", :unique => true

  create_table "users", :force => true do |t|
    t.string   "display_name"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "email",                :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.integer  "sign_in_count",        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
