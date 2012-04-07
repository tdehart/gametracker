class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :link
      t.string :region
      t.date :tournament_date
      t.integer :prize_pool
      t.integer :num_competitors
      t.string :stream_link
      t.time :stream_time
      t.integer :game_id

      t.timestamps
    end
    add_index :tournaments, :game_id
  end
end
