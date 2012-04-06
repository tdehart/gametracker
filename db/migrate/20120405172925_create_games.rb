class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :website
      t.string :genre
      t.integer :players

      t.integer :developer_id

      t.timestamps
    end

    add_index :games, :name
    add_index :games, :genre
    add_index :games, :developer_id
  end
end
