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

ActiveRecord::Schema.define(version: 2020_11_14_184656) do

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

  create_table "form_builders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "formname"
    t.text "formdata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.string "DisplayName"
    t.string "Email"
    t.string "Role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "eduPersonPrincipalName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
