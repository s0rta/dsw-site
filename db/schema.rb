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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160619043445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "intarray"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "cmsimple_images", force: :cascade do |t|
    t.string   "attachment",   limit: 255
    t.string   "width",        limit: 255
    t.string   "height",       limit: 255
    t.string   "file_size",    limit: 255
    t.string   "content_type", limit: 255
    t.string   "title",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cmsimple_pages", force: :cascade do |t|
    t.string   "uri",           limit: 255,                 null: false
    t.string   "template",      limit: 255
    t.text     "content"
    t.string   "title",         limit: 255
    t.integer  "parent_id"
    t.integer  "position",                  default: 0
    t.string   "slug",          limit: 255
    t.boolean  "is_root",                   default: false
    t.string   "keywords",      limit: 255
    t.text     "description"
    t.string   "browser_title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "cmsimple_pages", ["parent_id"], name: "index_cmsimple_pages_on_parent_id", using: :btree
  add_index "cmsimple_pages", ["published_at"], name: "index_cmsimple_pages_on_published_at", using: :btree
  add_index "cmsimple_pages", ["uri"], name: "index_cmsimple_pages_on_path", using: :btree

  create_table "cmsimple_paths", force: :cascade do |t|
    t.string   "uri",          limit: 255
    t.string   "redirect_uri", limit: 255
    t.integer  "page_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cmsimple_versions", force: :cascade do |t|
    t.text     "content"
    t.string   "template",     limit: 255
    t.datetime "published_at"
    t.integer  "page_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "cmsimple_versions", ["page_id"], name: "index_cmsimple_versions_on_page_id", using: :btree
  add_index "cmsimple_versions", ["published_at"], name: "index_cmsimple_versions_on_published_at", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "comments", ["submission_id"], name: "index_comments_on_submission_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "newsletter_signups", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.string   "contact_email",  limit: 255
    t.string   "zip",            limit: 255
    t.string   "company",        limit: 255
    t.string   "gender",         limit: 255
    t.string   "primary_role",   limit: 255
    t.integer  "track_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "calendar_token", limit: 255
  end

  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id", using: :btree

  create_table "session_registrations", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "submission_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "session_registrations", ["registration_id"], name: "index_session_registrations_on_registration_id", using: :btree
  add_index "session_registrations", ["submission_id"], name: "index_session_registrations_on_submission_id", using: :btree

  create_table "sponsor_signups", force: :cascade do |t|
    t.string   "contact_name",  limit: 255
    t.string   "contact_email", limit: 255
    t.string   "company",       limit: 255
    t.text     "interest"
    t.text     "notes"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "submitter_id"
    t.integer  "track_id"
    t.string   "format",            limit: 255
    t.string   "location",          limit: 255
    t.string   "time_range",        limit: 255
    t.string   "title",             limit: 255
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "contact_email",     limit: 255
    t.string   "estimated_size",    limit: 255
    t.boolean  "is_confirmed",                  default: false, null: false
    t.boolean  "is_public",                     default: true,  null: false
    t.integer  "venue_id"
    t.integer  "volunteers_needed"
    t.integer  "budget_needed"
    t.float    "start_hour",                    default: 0.0,   null: false
    t.float    "end_hour",                      default: 0.0,   null: false
    t.integer  "year"
    t.string   "state",             limit: 255
    t.integer  "start_day"
    t.integer  "end_day"
  end

  add_index "submissions", ["submitter_id"], name: "index_submissions_on_submitter_id", using: :btree
  add_index "submissions", ["track_id"], name: "index_submissions_on_track_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "icon",           limit: 255
    t.string   "email_alias",    limit: 255
    t.integer  "display_order",              default: 0,     null: false
    t.boolean  "is_submittable",             default: false, null: false
  end

  create_table "tracks_users", id: false, force: :cascade do |t|
    t.integer "track_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "description",            limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_admin",                           default: false, null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description"
    t.string   "contact_name",  limit: 255
    t.string   "contact_email", limit: 255
    t.string   "contact_phone", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "address",       limit: 255
    t.string   "city",          limit: 255
    t.string   "state",         limit: 255
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "volunteer_signups", force: :cascade do |t|
    t.string   "contact_name",  limit: 255
    t.string   "contact_email", limit: 255
    t.text     "interest"
    t.text     "notes"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["submission_id"], name: "index_votes_on_submission_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
