class AddIndexToDevelopersName < ActiveRecord::Migration
  def change
    add_index :developers, :name, unique: true
  end
end
