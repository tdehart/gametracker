class AddCurrencyIsoCodeToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :currency_iso_code, :string
  end
end
