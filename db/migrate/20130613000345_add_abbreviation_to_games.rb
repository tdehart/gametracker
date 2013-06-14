class AddAbbreviationToGames < ActiveRecord::Migration
  def change
    add_column :games, :abbreviation, :string
  end
end
