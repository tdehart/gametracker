class RemoveStreamIdFromGames < ActiveRecord::Migration
  def change
    remove_index :games, :stream_id
    remove_column :games, :stream_id
  end
end
