class CreateGamesStreamsTable < ActiveRecord::Migration
  def change
    create_table :games_streams, :id => false do |t|
      t.references :game
      t.references :stream
    end
    add_index :games_streams, [:game_id, :stream_id]
    add_index :games_streams, [:stream_id, :game_id]
  end
end
