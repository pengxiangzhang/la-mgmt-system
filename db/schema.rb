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

ActiveRecord::Schema.define(version: 2020_09_25_011617) do

  create_table "AnimalEntity", primary_key: "tagNumber", id: :integer, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hunger"
    t.integer "massInKg"
    t.string "name"
    t.integer "pricePerKg"
    t.string "reactionToFeeding"
    t.string "reactionToPetting"
    t.string "reactionToWatching"
    t.integer "sex"
    t.string "species"
    t.integer "stress"
    t.integer "type"
    t.string "location_name", limit: 128
    t.integer "zoo_id"
    t.index ["location_name"], name: "FKc1qtho9nl2ytwk71bs9y8mkjj"
    t.index ["zoo_id"], name: "FKmqf2ome5a0tx7gssbmp6hveo8"
  end

  create_table "Ballot", primary_key: "BallotId", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "choice"
    t.string "issue"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.string "option4"
    t.string "option5"
    t.integer "VoterId"
  end

  create_table "BallotEntity", primary_key: "BallotId", id: :integer, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.blob "choice", limit: 255
    t.blob "issues", limit: 255
    t.blob "options", limit: 255
    t.integer "VoterId"
    t.index ["VoterId"], name: "FK5hq0k48exuv2qqycusxu00t3r"
  end

  create_table "Fruit", id: :integer, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color"
    t.string "fruitType"
    t.integer "massInGrams"
    t.integer "salad_id"
    t.index ["salad_id"], name: "FK10vagrio8cwhs2j4pr8e64jkh"
  end

  create_table "FruitSalad", id: :integer, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "recipeName"
  end

  create_table "LocationEntity", primary_key: "name", id: :string, limit: 128, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "type"
    t.integer "zoo_id"
    t.index ["zoo_id"], name: "FK30rtxt2bq5n7qtpsinyhfwwle"
  end

  create_table "Member", primary_key: "memberId", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "discordUser"
  end

  create_table "PettingZoo", id: :integer, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "admissionPrice", limit: 53
    t.float "bankBalance", limit: 53
    t.float "expensesFood", limit: 53
    t.float "expensesPay", limit: 53
    t.float "expensesPurchase", limit: 53
    t.datetime "lastUpdate"
    t.float "publicInterest", limit: 53
    t.float "revenue", limit: 53
    t.integer "ticketsSold"
  end

  create_table "VoterEntity", primary_key: "VoterId", id: :integer, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hasVoted"
    t.string "name"
    t.string "ssn"
  end

  create_table "hibernate_sequence", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "next_val"
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "session_id", null: false
    t.string "cas_ticket"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cas_ticket"], name: "index_sessions_on_cas_ticket"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
