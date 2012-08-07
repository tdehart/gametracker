class AddApprovedToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :approved, :boolean, :default => false
  end
end
