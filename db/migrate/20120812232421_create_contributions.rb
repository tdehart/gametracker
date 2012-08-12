class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :tournament_id
      t.integer :contributor_id

      t.timestamps
    end

    add_index :contributions, :tournament_id
    add_index :contributions, :contributor_id
    add_index :contributions, [:tournament_id, :contributor_id], unique: true
  end
end
