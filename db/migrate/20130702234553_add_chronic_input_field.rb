class AddChronicInputField < ActiveRecord::Migration
  def change
    add_column :events, :chronic_input, :string
  end
end
