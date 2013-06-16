class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :feedable, polymorphic: true
      t.references :owner, polymorphic: true
      t.references :recipient, polymorphic: true
      t.string :key

      t.timestamps
    end

    add_index :feed_items, [:feedable_id, :feedable_type]
    add_index :feed_items, [:owner_id, :owner_type]
    add_index :feed_items, [:recipient_id, :recipient_type]
  end
end
