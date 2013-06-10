class RenameContributionsToTournamentContributions < ActiveRecord::Migration
  def change
    rename_table :contributions, :tournament_contributions
  end
end
