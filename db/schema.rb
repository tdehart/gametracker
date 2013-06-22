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

ActiveRecord::Schema.define(:version => 20130622175831) do

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.string   "slug"
  end

  add_index "developers", ["name"], :name => "index_developers_on_name", :unique => true
  add_index "developers", ["slug"], :name => "index_developers_on_slug"

  create_table "events", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "stream_id"
    t.integer  "max_concurrent_viewers"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "name"
    t.datetime "event_time"
    t.text     "description"
  end

  add_index "events", ["event_time"], :name => "index_events_on_event_time"
  add_index "events", ["stream_id"], :name => "index_events_on_stream_id"
  add_index "events", ["tournament_id"], :name => "index_events_on_tournament_id"

  create_table "feed_items", :force => true do |t|
    t.integer  "feedable_id"
    t.string   "feedable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.string   "key"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "feed_items", ["feedable_id", "feedable_type"], :name => "index_feed_items_on_feedable_id_and_feedable_type"
  add_index "feed_items", ["owner_id", "owner_type"], :name => "index_feed_items_on_owner_id_and_owner_type"
  add_index "feed_items", ["recipient_id", "recipient_type"], :name => "index_feed_items_on_recipient_id_and_recipient_type"

  create_table "followed_games", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "followed_games", ["game_id"], :name => "index_followed_games_on_game_id"
  add_index "followed_games", ["user_id", "game_id"], :name => "index_followed_games_on_user_id_and_game_id", :unique => true
  add_index "followed_games", ["user_id"], :name => "index_followed_games_on_user_id"

  create_table "followed_tournaments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.boolean  "hidden"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "followed_tournaments", ["tournament_id"], :name => "index_followed_tournaments_on_tournament_id"
  add_index "followed_tournaments", ["user_id", "tournament_id"], :name => "index_followed_tournaments_on_user_id_and_tournament_id", :unique => true
  add_index "followed_tournaments", ["user_id"], :name => "index_followed_tournaments_on_user_id"

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "genre"
    t.integer  "num_players"
    t.integer  "developer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "image"
    t.string   "slug"
    t.string   "abbreviation"
  end

  add_index "games", ["developer_id"], :name => "index_games_on_developer_id"
  add_index "games", ["genre"], :name => "index_games_on_genre"
  add_index "games", ["name"], :name => "index_games_on_name"
  add_index "games", ["slug"], :name => "index_games_on_slug"

  create_table "games_streams", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "stream_id"
  end

  add_index "games_streams", ["game_id", "stream_id"], :name => "index_games_streams_on_game_id_and_stream_id"
  add_index "games_streams", ["stream_id", "game_id"], :name => "index_games_streams_on_stream_id_and_game_id"

  create_table "games_users", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "user_id"
  end

  add_index "games_users", ["game_id", "user_id"], :name => "index_games_users_on_game_id_and_user_id", :unique => true

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
    t.string   "slug"
  end

  add_index "streamers", ["slug"], :name => "index_streamers_on_slug"

  create_table "streamers_streams", :id => false, :force => true do |t|
    t.integer "streamer_id"
    t.integer "stream_id"
  end

  create_table "streams", :force => true do |t|
    t.string   "link"
    t.text     "description"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "channel_id"
    t.string   "platform"
    t.integer  "viewer_count",    :default => 0
    t.boolean  "live",            :default => false
    t.integer  "current_game_id"
  end

  add_index "streams", ["current_game_id"], :name => "index_streams_on_current_game_id"
  add_index "streams", ["live"], :name => "index_streams_on_live"

  create_table "tournament_contributions", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "contributor_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "submitter"
  end

  add_index "tournament_contributions", ["contributor_id"], :name => "index_contributions_on_contributor_id"
  add_index "tournament_contributions", ["tournament_id", "contributor_id"], :name => "index_contributions_on_tournament_id_and_contributor_id", :unique => true
  add_index "tournament_contributions", ["tournament_id"], :name => "index_contributions_on_tournament_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.string   "region"
    t.date     "start_date"
    t.integer  "prize_pool_cents"
    t.integer  "num_competitors"
    t.integer  "game_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "description",      :limit => 255
    t.string   "image"
  end

  add_index "tournaments", ["game_id"], :name => "index_tournaments_on_game_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "web_resources", :force => true do |t|
    t.string   "url"
    t.integer  "resourceable_id"
    t.string   "resourceable_type"
    t.string   "resource_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "web_resources", ["resourceable_id", "resourceable_type"], :name => "index_web_resources_on_resourceable_id_and_resourceable_type"

end
