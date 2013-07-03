class RemoveRegionFromTournaments < ActiveRecord::Migration
  def change
    remove_column :tournaments, :region
  end
end
