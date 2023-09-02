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

ActiveRecord::Schema[7.0].define(version: 2019_11_23_131451) do
  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "shorthand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coaches", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.integer "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_coaches_on_club_id"
  end

  create_table "contestant_rankings", force: :cascade do |t|
    t.string "contestant_name"
    t.integer "total_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weekly_ranking_id"
    t.integer "position"
    t.integer "weekly_score"
    t.index ["weekly_ranking_id"], name: "index_contestant_rankings_on_weekly_ranking_id"
  end

  create_table "contestants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.boolean "is_admin", default: false
  end

  create_table "login_requests", force: :cascade do |t|
    t.datetime "expires_at"
    t.string "validation_key"
    t.integer "contestant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_login_requests_on_contestant_id"
  end

  create_table "player_rankings", force: :cascade do |t|
    t.string "player_name"
    t.string "player_club"
    t.string "player_position"
    t.integer "player_value"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weekly_ranking_id"
    t.integer "position"
    t.index ["weekly_ranking_id"], name: "index_player_rankings_on_weekly_ranking_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.integer "club_id"
    t.string "type"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_players_on_club_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "superteams", force: :cascade do |t|
    t.integer "contestant_id"
    t.integer "coach_id"
    t.integer "bonus_player_id"
    t.integer "goalkeeper_id"
    t.integer "defender_a_id"
    t.integer "defender_b_id"
    t.integer "defender_c_id"
    t.integer "defender_d_id"
    t.integer "midfielder_a_id"
    t.integer "midfielder_b_id"
    t.integer "midfielder_c_id"
    t.integer "forward_a_id"
    t.integer "forward_b_id"
    t.integer "forward_c_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bonus_player_id"], name: "index_superteams_on_bonus_player_id"
    t.index ["coach_id"], name: "index_superteams_on_coach_id"
    t.index ["contestant_id"], name: "index_superteams_on_contestant_id"
    t.index ["defender_a_id"], name: "index_superteams_on_defender_a_id"
    t.index ["defender_b_id"], name: "index_superteams_on_defender_b_id"
    t.index ["defender_c_id"], name: "index_superteams_on_defender_c_id"
    t.index ["defender_d_id"], name: "index_superteams_on_defender_d_id"
    t.index ["forward_a_id"], name: "index_superteams_on_forward_a_id"
    t.index ["forward_b_id"], name: "index_superteams_on_forward_b_id"
    t.index ["forward_c_id"], name: "index_superteams_on_forward_c_id"
    t.index ["goalkeeper_id"], name: "index_superteams_on_goalkeeper_id"
    t.index ["midfielder_a_id"], name: "index_superteams_on_midfielder_a_id"
    t.index ["midfielder_b_id"], name: "index_superteams_on_midfielder_b_id"
    t.index ["midfielder_c_id"], name: "index_superteams_on_midfielder_c_id"
  end

  create_table "team_rankings", force: :cascade do |t|
    t.string "team_name"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weekly_ranking_id"
    t.integer "position"
    t.index ["weekly_ranking_id"], name: "index_team_rankings_on_weekly_ranking_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weekly_rankings", force: :cascade do |t|
    t.date "date"
  end

  add_foreign_key "contestant_rankings", "weekly_rankings"
  add_foreign_key "player_rankings", "weekly_rankings"
  add_foreign_key "team_rankings", "weekly_rankings"
end
