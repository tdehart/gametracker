class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :tournaments, :tournament_date, :date
    rename_column :games, :players, :num_players
  end
end
