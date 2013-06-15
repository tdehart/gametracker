class CreateEventContributions < ActiveRecord::Migration
  def change
    create_table :event_contributions do |t|
      t.integer :event_id
      t.integer :contributor_id
      t.boolean :submitter

      t.timestamps
    end

    add_index :event_contributions, :event_id
    add_index :event_contributions, :contributor_id
    add_index :event_contributions, [:event_id, :contributor_id], unique: true
  end
end
