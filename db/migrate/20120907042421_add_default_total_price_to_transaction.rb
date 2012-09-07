class AddDefaultTotalPriceToTransaction < ActiveRecord::Migration
  def change
    change_column :transactions, :total_price, :float, :default => 0.0 
  end
end
