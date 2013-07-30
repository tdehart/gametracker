class RemoveStreamIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :stream_id
  end
end
