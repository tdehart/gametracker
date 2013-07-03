class AddCompetitorTypeToGames < ActiveRecord::Migration
  def change
    add_column :games, :competitor_type, :string
  end
end
