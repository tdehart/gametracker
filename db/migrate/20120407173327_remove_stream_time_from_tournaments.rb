class RemoveStreamTimeFromTournaments < ActiveRecord::Migration
  def up
    remove_column :tournaments, :stream_time
      end

  def down
    add_column :tournaments, :stream_time, :time
  end
end
