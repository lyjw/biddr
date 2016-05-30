class AddCurrentPriceToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :current_price, :float, default: 0
  end
end
