class AddHiddenToFollowedTournaments < ActiveRecord::Migration
  def change
    add_column :followed_tournaments, :hidden, :boolean, default: false
  end
end
