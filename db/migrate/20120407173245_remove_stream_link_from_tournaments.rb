class RemoveStreamLinkFromTournaments < ActiveRecord::Migration
  def up
    remove_column :tournaments, :stream_link
      end

  def down
    add_column :tournaments, :stream_link, :string
  end
end
