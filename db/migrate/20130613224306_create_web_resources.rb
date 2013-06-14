class CreateWebResources < ActiveRecord::Migration
  def change
    create_table :web_resources do |t|
      t.string :url
      t.integer :resourceable_id
      t.string :resourceable_type
      t.string :resource_type

      t.timestamps
    end
  end
end
