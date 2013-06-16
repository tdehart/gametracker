class DropContributionTables < ActiveRecord::Migration
  def change
    drop_table :tournament_contributions
    drop_table :event_contributions
  end
end
