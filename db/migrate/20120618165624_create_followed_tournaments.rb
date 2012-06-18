class CreateFollowedTournaments < ActiveRecord::Migration
  def change
    create_table :followed_tournaments do |t|
      t.integer :user_id
      t.integer :tournament_id

      t.timestamps
    end

    add_index :followed_tournaments, :user_id
    add_index :followed_tournaments, :tournament_id
    add_index :followed_tournaments, [:user_id, :tournament_id], unique: true
  end
end
