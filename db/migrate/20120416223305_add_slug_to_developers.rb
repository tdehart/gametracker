class AddSlugToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :slug, :string
    add_index :developers, :slug
  end

end
