class AddImageToStreamers < ActiveRecord::Migration
  def change
    add_column :streamers, :image, :string
  end
end
