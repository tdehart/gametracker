class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :image
      t.integer :regionable_id
      t.string :regionable_type

      t.timestamps
    end
    add_index :regions, [:regionable_id, :regionable_type]
  end
end
