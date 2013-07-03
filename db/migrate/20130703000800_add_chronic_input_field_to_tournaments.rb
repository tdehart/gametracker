class AddChronicInputFieldToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :chronic_start_input, :string
    add_column :tournaments, :chronic_end_input, :string
  end
end
