class AddDatetimeToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date
    remove_column :events, :time
    add_column :events, :event_time, :datetime
    add_index :events, :event_time
  end
end
