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

ActiveRecord::Schema.define(version: 2018_07_25_000002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "spotify_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "spotify_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.string "spotify_id"
    t.bigint "user_id"
    t.string "tracks_url"
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.string "spotify_id"
    t.integer "popularity"
    t.date "release_date"
    t.bigint "artist_id"
    t.bigint "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "playlist_id"
    t.index ["album_id"], name: "index_tracks_on_album_id"
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
    t.index ["playlist_id"], name: "index_tracks_on_playlist_id"
  end

  create_table "user_tracks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "track_id"
    t.datetime "added_at"
    t.index ["track_id"], name: "index_user_tracks_on_track_id"
    t.index ["user_id"], name: "index_user_tracks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "spotify_id"
    t.string "name"
    t.string "email"
    t.string "token"
    t.string "refresh_token"
    t.datetime "token_exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_token"
    t.string "profile_picture"
  end

  add_foreign_key "tracks", "albums"
  add_foreign_key "tracks", "artists"
  add_foreign_key "tracks", "playlists"
  add_foreign_key "user_tracks", "tracks"
  add_foreign_key "user_tracks", "users"
end
