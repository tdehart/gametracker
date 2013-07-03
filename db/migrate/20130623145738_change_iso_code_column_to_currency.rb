class ChangeIsoCodeColumnToCurrency < ActiveRecord::Migration
  def change
    rename_column :tournaments, :currency_iso_code, :currency
  end
end
