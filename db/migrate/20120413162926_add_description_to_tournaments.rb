class AddDescriptionToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :description, :string
  end
end
