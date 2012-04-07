class CreateStreamers < ActiveRecord::Migration
  def change
    create_table :streamers do |t|
      t.string :online_name
      t.string :real_name
      t.string :nationality
      t.string :website
      t.date :birthday
      t.text :biography

      t.timestamps
    end
  end
end
