class AddPlatformToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :platform, :string
  end
end
