class AddInitialValuesToService < ActiveRecord::Migration
  def change
    change_column :services, :regular_price, :float, :default => 0.0 
    change_column :services, :member_price_morn, :float, :default => 0.0 
    change_column :services, :member_price_eve, :float, :default => 0.0 
  end
end
