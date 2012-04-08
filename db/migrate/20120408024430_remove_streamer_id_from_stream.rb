class RemoveStreamerIdFromStream < ActiveRecord::Migration
  def up
    remove_column :streams, :streamer_id
      end

  def down
    add_column :streams, :streamer_id, :string
  end
end
