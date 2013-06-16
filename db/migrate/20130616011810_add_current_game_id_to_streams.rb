class AddCurrentGameIdToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :current_game_id, :integer
    add_index :streams, :current_game_id
  end
end
