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

ActiveRecord::Schema.define(version: 2021_06_07_012900) do

  create_table "api_requests", force: :cascade do |t|
    t.string "endpoint"
    t.string "remote_ip"
    t.json "payload"
    t.datetime "created_at"
  end

  create_table "assigned_exams", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "exam_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id"], name: "index_assigned_exams_on_exam_id"
    t.index ["user_id"], name: "index_assigned_exams_on_user_id"
  end

  create_table "colleges", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exams", force: :cascade do |t|
    t.integer "college_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["college_id"], name: "index_exams_on_college_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name", "last_name", "phone_number"], name: "index_users_on_first_name_and_last_name_and_phone_number", unique: true
  end

  add_foreign_key "assigned_exams", "exams"
  add_foreign_key "assigned_exams", "users"
  add_foreign_key "exams", "colleges"
end
