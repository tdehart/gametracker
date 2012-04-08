class AddStreamersStreamsTable < ActiveRecord::Migration
  def change
    create_table :streamers_streams, :id => false do |t|
      t.integer :streamer_id
      t.integer :stream_id
    end
  end
end

