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

ActiveRecord::Schema[7.0].define(version: 2022_10_27_070619) do
  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.date "opening_date", null: false
    t.time "start_time", null: false
    t.time "finish_time", null: false
    t.integer "interval", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "department"
    t.string "position"
    t.string "grade"
    t.string "name", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_members_on_event_id"
  end

  create_table "members_schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "schedule_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_members_schedules_on_event_id"
    t.index ["member_id"], name: "index_members_schedules_on_member_id"
    t.index ["schedule_id"], name: "index_members_schedules_on_schedule_id"
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "time_zone", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_schedules_on_event_id"
  end

  create_table "shifts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "work_id", null: false
    t.bigint "schedule_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_shifts_on_event_id"
    t.index ["member_id"], name: "index_shifts_on_member_id"
    t.index ["schedule_id"], name: "index_shifts_on_schedule_id"
    t.index ["work_id"], name: "index_shifts_on_work_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_works_on_event_id"
  end

  create_table "works_schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "schedule_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_works_schedules_on_event_id"
    t.index ["schedule_id"], name: "index_works_schedules_on_schedule_id"
    t.index ["work_id"], name: "index_works_schedules_on_work_id"
  end

  add_foreign_key "events", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "members", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "members_schedules", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "members_schedules", "members", on_update: :cascade, on_delete: :cascade
  add_foreign_key "members_schedules", "schedules", on_update: :cascade, on_delete: :cascade
  add_foreign_key "schedules", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shifts", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shifts", "members", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shifts", "schedules", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shifts", "works", on_update: :cascade, on_delete: :cascade
  add_foreign_key "works", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "works_schedules", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "works_schedules", "schedules", on_update: :cascade, on_delete: :cascade
  add_foreign_key "works_schedules", "works", on_update: :cascade, on_delete: :cascade
end
