class AddChannelIdToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :channel_id, :string
  end
end
