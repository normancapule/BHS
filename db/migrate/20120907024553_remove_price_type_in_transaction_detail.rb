class RemovePriceTypeInTransactionDetail < ActiveRecord::Migration
  def change
    remove_column :transaction_details, :price_type
  end
end
