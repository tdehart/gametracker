class AddViewerCountLiveToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :viewer_count, :integer, :default => 0
    add_column :streams, :live, :boolean, :default => false
    add_index :streams, :live
  end

end
