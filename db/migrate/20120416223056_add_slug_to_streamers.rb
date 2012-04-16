class AddSlugToStreamers < ActiveRecord::Migration
  def change
    add_column :streamers, :slug, :string
    add_index :streamers, :slug
  end

end
