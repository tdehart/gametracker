class UpdateMoneyColumn < ActiveRecord::Migration
  def change
    change_column :tournaments, :prize_pool_cents, :bigint
  end
end
