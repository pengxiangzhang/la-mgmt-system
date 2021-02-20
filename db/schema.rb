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

ActiveRecord::Schema.define(version: 2021_02_12_234443) do

  create_table "applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.string "NUID"
    t.string "Name"
    t.string "Email"
    t.string "Course"
    t.decimal "GPA", precision: 10
    t.decimal "Score", precision: 10
    t.string "File_Location"
    t.string "Application_Status"
    t.datetime "Interview_Time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.text "close_reason"
    t.string "location"
    t.datetime "startTime"
    t.datetime "endTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "course_name"
    t.string "slack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_builders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "formname"
    t.text "formdata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "la_courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "la_detail_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_la_courses_on_course_id"
    t.index ["la_detail_id"], name: "index_la_courses_on_la_detail_id"
  end

  create_table "la_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_detail_id"
    t.string "Monday"
    t.string "Tuesday"
    t.string "Wednesday"
    t.string "Thursday"
    t.string "Friday"
    t.string "Saturday"
    t.string "Sunday"
    t.boolean "allowChangeHour", default: true
    t.string "announcement", default: "No announcement found"
    t.string "location", default: "No location found"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_detail_id"], name: "index_la_details_on_user_detail_id"
  end

  create_table "sessions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "session_id", null: false
    t.string "cas_ticket", limit: 1000
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.string "DisplayName"
    t.string "Email"
    t.string "Role"
    t.boolean "hasAppointment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "la_courses", "courses"
  add_foreign_key "la_courses", "la_details"
  add_foreign_key "la_details", "user_details"
end
