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

ActiveRecord::Schema.define(version: 20170131095912) do

  create_table "contents", force: :cascade do |t|
    t.text     "opinion"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "participant_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "current_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "discription"
  end

  create_table "ideas_users", id: false, force: :cascade do |t|
    t.integer "idea_id", null: false
    t.integer "user_id", null: false
  end

  create_table "ideas_users_{:id=>false}", id: false, force: :cascade do |t|
    t.integer "ideas_user_id",   null: false
    t.integer "{:id=>false}_id", null: false
    t.integer "idea_id"
    t.integer "user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "permission"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "permission"
  end

end
