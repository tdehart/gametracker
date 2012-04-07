class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :tournament_id
      t.integer :stream_id
      t.date :date
      t.time :time
      t.integer :max_concurrent_viewers

      t.timestamps
    end
    add_index :events, :tournament_id
    add_index :events, :stream_id
    add_index :events, [:tournament_id, :stream_id], unique: true
  end
end
