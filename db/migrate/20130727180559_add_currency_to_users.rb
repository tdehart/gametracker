class AddCurrencyToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :currency_iso_code, :string
  end
end
