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

ActiveRecord::Schema.define(version: 20160828132727) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.integer  "target_type"
    t.integer  "action_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "cover_image_name"
    t.integer  "number_of_pages"
    t.text     "description"
    t.datetime "publish_date"
    t.integer  "price"
    t.integer  "author_id"
    t.integer  "category_id"
    t.integer  "publisher_id"
    t.integer  "language_id"
    t.boolean  "is_in_library",    default: false
    t.float    "average_rating"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["category_id"], name: "index_books_on_category_id"
  add_index "books", ["language_id"], name: "index_books_on_language_id"
  add_index "books", ["publisher_id"], name: "index_books_on_publisher_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_book_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["user_book_id"], name: "index_comments_on_user_book_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "likes", ["activity_id"], name: "index_likes_on_activity_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "requests", ["book_id"], name: "index_requests_on_book_id"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "user_books", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "status"
    t.boolean  "is_favorite", default: false
    t.float    "rating"
    t.text     "review"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "user_books", ["book_id"], name: "index_user_books_on_book_id"
  add_index "user_books", ["user_id"], name: "index_user_books_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "remeber_digest"
    t.integer  "role",                   default: 1
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
