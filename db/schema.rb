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

ActiveRecord::Schema[8.0].define(version: 2025_07_25_045330) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "lineup_entries", force: :cascade do |t|
    t.bigint "lineup_id", null: false
    t.bigint "player_id", null: false
    t.integer "batting_order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lineup_id"], name: "index_lineup_entries_on_lineup_id"
    t.index ["player_id"], name: "index_lineup_entries_on_player_id"
  end

  create_table "lineups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.text "description"
    t.float "expected_score", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lineups_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "team"
    t.string "position"
    t.string "description"
    t.float "stat_1b", default: 0.0, null: false
    t.float "stat_2b", default: 0.0, null: false
    t.float "stat_3b", default: 0.0, null: false
    t.float "stat_hr", default: 0.0, null: false
    t.float "stat_out", default: 1.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "lineup_entries", "lineups"
  add_foreign_key "lineup_entries", "players"
  add_foreign_key "lineups", "users"
  add_foreign_key "players", "users"
end
