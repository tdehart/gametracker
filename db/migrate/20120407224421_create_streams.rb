class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :streamer_id
      t.string :link
      t.text :description

      t.timestamps
    end
    add_index :streams, :streamer_id
  end
end
