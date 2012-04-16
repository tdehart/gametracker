class RemoveStreamsGamesTable < ActiveRecord::Migration
  def change
    drop_table :streams_games, :id => false do |t|
      t.integer :stream_id
      t.integer :game_id
    end
  end
end
