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

  create_table "form_builders", charset: "utf8", force: :cascade do |t|
    t.string "formname"
    t.text "formdata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "la_courses", "courses"
  add_foreign_key "la_courses", "la_details"
  add_foreign_key "la_details", "user_details"
end
