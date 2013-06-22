class RenameTournamentsPrizePool < ActiveRecord::Migration
  def change 
    rename_column :tournaments, :prize_pool, :prize_pool_cents
  end
end
