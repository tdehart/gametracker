class CreateEventsStreamsTable < ActiveRecord::Migration
  def change
    create_table :events_streams, :id => false do |t|
      t.references :event
      t.references :stream
    end

    add_index :events_streams, [:event_id, :stream_id], unique: true
  end
end
