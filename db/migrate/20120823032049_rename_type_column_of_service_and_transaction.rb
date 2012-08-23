class RenameTypeColumnOfServiceAndTransaction < ActiveRecord::Migration
  def up
    rename_column :transactions, :type, :transaction_type
    rename_column :services, :type, :service_type
  end

  def down
  end
end
