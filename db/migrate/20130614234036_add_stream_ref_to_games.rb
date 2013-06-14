class AddStreamRefToGames < ActiveRecord::Migration
  def change
    add_column :games, :stream_id, :integer
    add_index :games, :stream_id
  end
end
