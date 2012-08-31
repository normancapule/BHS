class AddDateTimeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transac_date, :date
  end
end
