class RemoveTournamentStreamIndexFromEvents < ActiveRecord::Migration
  def change
    remove_index "events", ["tournament_id", "stream_id"]
  end
end
