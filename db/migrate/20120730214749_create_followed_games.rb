class CreateFollowedGames < ActiveRecord::Migration
  def change
    create_table :followed_games do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end

    add_index :followed_games, :user_id
    add_index :followed_games, :game_id
    add_index :followed_games, [:user_id, :game_id], unique: true
  end
end
