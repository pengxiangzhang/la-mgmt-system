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

ActiveRecord::Schema.define(version: 2021_04_17_185941) do

  create_table "announcements", primary_key: "announcement_key", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "course", limit: 20
    t.string "class", limit: 20
    t.string "body", limit: 500
    t.index ["course"], name: "course", unique: true
  end

  create_table "applications", charset: "utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.string "NUID"
    t.string "Name"
    t.string "Email"
    t.string "Course"
    t.decimal "GPA", precision: 10
    t.decimal "Score", precision: 10
    t.string "File_Location"
    t.string "Application_Status"
    t.string "Sub_Status"
    t.datetime "Interview_Time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", charset: "utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.string "displayName"
    t.string "email"
    t.datetime "datetime"
    t.string "class_id"
    t.string "the_method"
    t.integer "duration"
    t.string "la_eduPersonPrincipalName"
    t.datetime "la_accept_time"
    t.string "status"
    t.text "notes"
    t.text "description"
    t.text "close_reason"
    t.text "laFeedback"
    t.string "location"
    t.datetime "startTime"
    t.datetime "endTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", charset: "utf8", force: :cascade do |t|
    t.string "course_name"
    t.string "slack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cse_usernames", primary_key: "username_key", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "username", limit: 20
    t.string "canvas_username", limit: 20
    t.string "name", limit: 70
    t.string "course", limit: 10
    t.string "email", limit: 100
    t.boolean "is_admin", default: false
    t.index ["username", "canvas_username", "course"], name: "cse_usernames_uindex", unique: true
  end

  create_table "feedback", primary_key: "feedback_key", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.integer "interaction_key", null: false
    t.integer "rating", limit: 1, default: 0
    t.string "comment", limit: 500
    t.integer "sentiment"
    t.boolean "desires_feedback"
    t.integer "time_to_complete"
    t.index ["interaction_key"], name: "interaction_key", unique: true
  end

  create_table "form_builders", charset: "utf8", force: :cascade do |t|
    t.string "formname"
    t.text "formdata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interactions", primary_key: "interaction_key", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.integer "la_username_key", null: false
    t.integer "student_username_key", null: false
    t.string "course", limit: 10
    t.string "interaction_type", limit: 30
    t.boolean "seeking_feedback", default: false, null: false
    t.boolean "has_received_feedback", default: false
    t.timestamp "time_of_interaction", default: -> { "current_timestamp()" }, null: false
    t.boolean "was_recommended", default: false, null: false
    t.index ["interaction_key"], name: "interactions_interaction_key_uindex", unique: true
    t.index ["la_username_key"], name: "interactions_la_fk"
    t.index ["student_username_key"], name: "interactions_student_fk"
  end

  create_table "la_courses", charset: "utf8", force: :cascade do |t|
    t.bigint "la_detail_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_la_courses_on_course_id"
    t.index ["la_detail_id"], name: "index_la_courses_on_la_detail_id"
  end

  create_table "la_details", charset: "utf8", force: :cascade do |t|
    t.bigint "user_detail_id"
    t.string "Monday"
    t.string "Tuesday"
    t.string "Wednesday"
    t.string "Thursday"
    t.string "Friday"
    t.string "Saturday"
    t.string "Sunday"
    t.boolean "allowChangeHour", default: true
    t.string "announcement", default: "No Announcements Found"
    t.string "location", default: "No Location Found"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_detail_id"], name: "index_la_details_on_user_detail_id"
  end

  create_table "lapromt_announcements", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "text"
    t.string "color_1"
    t.string "color_2"
    t.string "color_3"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "logins", primary_key: "login_key", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.integer "la_username_key", null: false
    t.timestamp "time_of_interaction", default: -> { "current_timestamp()" }, null: false
    t.index ["la_username_key"], name: "interactions_la_login_fk"
  end

  create_table "sessions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "session_id", null: false
    t.string "cas_ticket", limit: 1000
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_values", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_details", charset: "utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.string "DisplayName", default: "NULL"
    t.string "Email", default: "NULL"
    t.string "Role", default: "Student"
    t.boolean "hasAppointment", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "feedback", "interactions", column: "interaction_key", primary_key: "interaction_key", name: "feedback_interaction_fk", on_delete: :cascade
  add_foreign_key "interactions", "cse_usernames", column: "la_username_key", primary_key: "username_key", name: "interactions_la_fk", on_delete: :cascade
  add_foreign_key "interactions", "cse_usernames", column: "student_username_key", primary_key: "username_key", name: "interactions_student_fk", on_delete: :cascade
  add_foreign_key "la_courses", "courses"
  add_foreign_key "la_courses", "la_details"
  add_foreign_key "la_details", "user_details"
  add_foreign_key "logins", "cse_usernames", column: "la_username_key", primary_key: "username_key", name: "interactions_la_login_fk", on_delete: :cascade
end
