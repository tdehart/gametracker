class ChangeTournamentsDescriptionToText < ActiveRecord::Migration
  def change
    change_column :tournaments, :description, :text
  end
end
