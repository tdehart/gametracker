class CreateGamesUsersTable < ActiveRecord::Migration
  def change
    create_table :games_users, :id => false do |t|
      t.integer :game_id
      t.integer :user_id
    end

    add_index :games_users, [:game_id, :user_id], unique: true
  end
end
