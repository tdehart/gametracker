# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120416215639) do

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  add_index "developers", ["name"], :name => "index_developers_on_name", :unique => true

  create_table "events", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "stream_id"
    t.date     "date"
    t.time     "time"
    t.integer  "max_concurrent_viewers"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "name"
  end

  add_index "events", ["stream_id"], :name => "index_events_on_stream_id"
  add_index "events", ["tournament_id", "stream_id"], :name => "index_events_on_tournament_id_and_stream_id", :unique => true
  add_index "events", ["tournament_id"], :name => "index_events_on_tournament_id"

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "genre"
    t.integer  "num_players"
    t.integer  "developer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "image"
  end

  add_index "games", ["developer_id"], :name => "index_games_on_developer_id"
  add_index "games", ["genre"], :name => "index_games_on_genre"
  add_index "games", ["name"], :name => "index_games_on_name"

  create_table "games_streams", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "stream_id"
  end

  add_index "games_streams", ["game_id", "stream_id"], :name => "index_games_streams_on_game_id_and_stream_id"
  add_index "games_streams", ["stream_id", "game_id"], :name => "index_games_streams_on_stream_id_and_game_id"

  create_table "streamers", :force => true do |t|
    t.string   "online_name"
    t.string   "real_name"
    t.string   "nationality"
    t.string   "website"
    t.date     "birthday"
    t.text     "biography"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
  end

  create_table "streamers_streams", :id => false, :force => true do |t|
    t.integer "streamer_id"
    t.integer "stream_id"
  end

  create_table "streams", :force => true do |t|
    t.string   "link"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.string   "region"
    t.date     "date"
    t.integer  "prize_pool"
    t.integer  "num_competitors"
    t.integer  "game_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "description"
  end

  add_index "tournaments", ["game_id"], :name => "index_tournaments_on_game_id"

end
