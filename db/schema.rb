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

ActiveRecord::Schema.define(:version => 20140718155905) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "cmsimple_images", :force => true do |t|
    t.string   "attachment"
    t.string   "width"
    t.string   "height"
    t.string   "file_size"
    t.string   "content_type"
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "cmsimple_pages", :force => true do |t|
    t.string   "uri",                              :null => false
    t.string   "template"
    t.text     "content"
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "position",      :default => 0
    t.string   "slug"
    t.boolean  "is_root",       :default => false
    t.string   "keywords"
    t.text     "description"
    t.string   "browser_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "cmsimple_pages", ["parent_id"], :name => "index_cmsimple_pages_on_parent_id"
  add_index "cmsimple_pages", ["published_at"], :name => "index_cmsimple_pages_on_published_at"
  add_index "cmsimple_pages", ["uri"], :name => "index_cmsimple_pages_on_path"

  create_table "cmsimple_paths", :force => true do |t|
    t.string   "uri"
    t.string   "redirect_uri"
    t.integer  "page_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "cmsimple_versions", :force => true do |t|
    t.text     "content"
    t.string   "template"
    t.datetime "published_at"
    t.integer  "page_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "cmsimple_versions", ["page_id"], :name => "index_cmsimple_versions_on_page_id"
  add_index "cmsimple_versions", ["published_at"], :name => "index_cmsimple_versions_on_published_at"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "comments", ["submission_id"], :name => "index_comments_on_submission_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "newsletter_signups", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.string   "contact_email"
    t.string   "zip"
    t.string   "company"
    t.string   "gender"
    t.string   "primary_role"
    t.integer  "track_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "registrations", ["user_id"], :name => "index_registrations_on_user_id"

  create_table "session_registrations", :force => true do |t|
    t.integer  "registration_id"
    t.integer  "submission_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "session_registrations", ["registration_id"], :name => "index_session_registrations_on_registration_id"
  add_index "session_registrations", ["submission_id"], :name => "index_session_registrations_on_submission_id"

  create_table "sponsor_signups", :force => true do |t|
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "company"
    t.text     "interest"
    t.text     "notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "submissions", :force => true do |t|
    t.integer  "submitter_id"
    t.integer  "track_id"
    t.string   "format"
    t.string   "location"
    t.string   "start_day"
    t.string   "time_range"
    t.string   "title"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "contact_email"
    t.string   "estimated_size"
    t.boolean  "is_confirmed",      :default => false, :null => false
    t.boolean  "is_public",         :default => true,  :null => false
    t.integer  "venue_id"
    t.integer  "volunteers_needed"
    t.integer  "budget_needed"
    t.float    "start_hour"
    t.float    "end_hour"
    t.string   "end_day"
    t.integer  "year"
    t.string   "state"
  end

  add_index "submissions", ["submitter_id"], :name => "index_submissions_on_submitter_id"
  add_index "submissions", ["track_id"], :name => "index_submissions_on_track_id"

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "icon"
    t.integer  "zerista_track_id"
    t.string   "email_alias"
  end

  create_table "tracks_users", :id => false, :force => true do |t|
    t.integer "track_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "linkedin_uid"
    t.string   "name"
    t.string   "email"
    t.string   "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_admin",     :default => false, :null => false
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "address"
    t.string   "city"
    t.string   "state"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "volunteer_signups", :force => true do |t|
    t.string   "contact_name"
    t.string   "contact_email"
    t.text     "interest"
    t.text     "notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votes", ["submission_id"], :name => "index_votes_on_submission_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
