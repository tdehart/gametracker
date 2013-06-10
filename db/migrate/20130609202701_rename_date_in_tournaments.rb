class RenameDateInTournaments < ActiveRecord::Migration
  def change
    rename_column :tournaments, :date, :start_date
  end
end
