class AddIndexesToWebResources < ActiveRecord::Migration
  def change
    add_index :web_resources, [:resourceable_id, :resourceable_type]
  end
end
