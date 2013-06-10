class RemoveApprovedFromTournament < ActiveRecord::Migration
  def change
    remove_column :tournaments, :approved
  end
end
