class AddSubmitterToTournamentContributions < ActiveRecord::Migration
  def change
    add_column :tournament_contributions, :submitter, :boolean
  end
end
