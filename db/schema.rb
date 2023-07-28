# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_20_220907) do
  create_table "logs", charset: "utf8mb3", force: :cascade do |t|
    t.string "view"
    t.string "action"
    t.integer "user_id"
    t.string "user_name"
    t.json "request_payload"
    t.string "message"
    t.boolean "has_error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referral_comments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "referral_id", null: false
    t.bigint "referral_status_id", null: false
    t.bigint "created_by_id"
    t.text "comment"
    t.string "created_by_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_referral_comments_on_created_by_id"
    t.index ["referral_id"], name: "index_referral_comments_on_referral_id"
    t.index ["referral_status_id"], name: "index_referral_comments_on_referral_status_id"
  end

  create_table "referral_status_histories", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "referral_id", null: false
    t.bigint "referral_status_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referral_id"], name: "index_referral_status_histories_on_referral_id"
    t.index ["referral_status_id"], name: "index_referral_status_histories_on_referral_status_id"
    t.index ["user_id"], name: "index_referral_status_histories_on_user_id"
  end

  create_table "referral_statuses", charset: "utf8mb3", force: :cascade do |t|
    t.string "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referral_system_email_users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email"
    t.text "access_token"
    t.text "refresh_token"
    t.datetime "token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrals", charset: "utf8mb3", force: :cascade do |t|
    t.integer "referred_by"
    t.string "full_name"
    t.string "phone_number"
    t.string "email"
    t.string "linkedin_url"
    t.string "cv_url"
    t.text "tech_stack"
    t.integer "ta_recruiter"
    t.integer "referral_status_id"
    t.text "comments"
    t.date "signed_date"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "referral_comments", "referral_statuses"
  add_foreign_key "referral_comments", "referrals"
  add_foreign_key "referral_comments", "users", column: "created_by_id"
  add_foreign_key "referral_status_histories", "referral_statuses"
  add_foreign_key "referral_status_histories", "referrals"
  add_foreign_key "referral_status_histories", "users"
end
