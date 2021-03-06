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

ActiveRecord::Schema.define(version: 20170130175748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "campaign_users", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_campaign_users_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_campaign_users_on_user_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "subject"
    t.text     "description"
    t.integer  "organization_id"
    t.integer  "cause_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "followers_count",   default: 0
    t.integer  "likers_count",      default: 0
    t.string   "small_description"
    t.string   "image"
    t.index ["cause_id"], name: "index_campaigns_on_cause_id", using: :btree
    t.index ["organization_id"], name: "index_campaigns_on_organization_id", using: :btree
  end

  create_table "cause_fundraises", force: :cascade do |t|
    t.integer  "cause_id"
    t.integer  "fundraise_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cause_organizations", force: :cascade do |t|
    t.integer  "cause_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["cause_id"], name: "index_cause_organizations_on_cause_id", using: :btree
    t.index ["organization_id"], name: "index_cause_organizations_on_organization_id", using: :btree
  end

  create_table "causes", force: :cascade do |t|
    t.string   "subject"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "followers_count",   default: 0
    t.integer  "likers_count",      default: 0
    t.string   "small_description"
    t.string   "image"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_causes_on_user_id", using: :btree
  end

  create_table "chat_room_users", force: :cascade do |t|
    t.integer  "chat_room_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["chat_room_id"], name: "index_chat_room_users_on_chat_room_id", using: :btree
    t.index ["user_id"], name: "index_chat_room_users_on_user_id", using: :btree
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "friend_id"
    t.index ["user_id"], name: "index_chat_rooms_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "description"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
    t.index ["friend_id", "friendable_id"], name: "index_friendships_on_friend_id_and_friendable_id", using: :btree
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", using: :btree
    t.index ["friendable_id", "friendable_type"], name: "index_friendships_on_friendable_id_and_friendable_type", using: :btree
  end

  create_table "fundraise_payment_details", force: :cascade do |t|
    t.string   "full_name"
    t.string   "ifsc_code"
    t.integer  "fundraise_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "amount_to_be_paid"
    t.string   "account_number"
    t.index ["fundraise_id"], name: "index_fundraise_payment_details_on_fundraise_id", using: :btree
  end

  create_table "fundraises", force: :cascade do |t|
    t.string   "subject"
    t.integer  "target"
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "followers_count",    default: 0
    t.integer  "likers_count",       default: 0
    t.string   "small_description"
    t.text     "description"
    t.string   "image"
    t.integer  "raised_amount",      default: 0
    t.boolean  "payment_is_pending"
    t.integer  "reedemed_amount",    default: 0
    t.index ["campaign_id"], name: "index_fundraises_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_fundraises_on_user_id", using: :btree
  end

  create_table "job_users", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_users_on_job_id", using: :btree
    t.index ["user_id"], name: "index_job_users_on_user_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "subject"
    t.text     "description"
    t.integer  "campaign_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_completed", default: false
    t.index ["campaign_id"], name: "index_jobs_on_campaign_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
    t.index ["liker_id", "liker_type"], name: "fk_likes", using: :btree
  end

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "chat_room_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "organization_users", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "role"
    t.string   "status"
    t.index ["organization_id"], name: "index_organization_users_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_organization_users_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "profile_image"
    t.string   "cover_image"
    t.integer  "followers_count", default: 0
    t.integer  "likers_count",    default: 0
    t.text     "description"
  end

  create_table "payments", force: :cascade do |t|
    t.float    "amount"
    t.integer  "fundraise_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["fundraise_id"], name: "index_payments_on_fundraise_id", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "image"
    t.integer  "likers_count", default: 0
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "stats", force: :cascade do |t|
    t.float    "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "profile_image"
    t.string   "cover_image"
    t.integer  "followers_count",        default: 0
    t.boolean  "admin",                  default: false
    t.float    "wallet_amount",          default: 0.0
    t.integer  "notification_count",     default: 0
    t.string   "full_name"
    t.string   "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "chat_rooms", "users"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
end
