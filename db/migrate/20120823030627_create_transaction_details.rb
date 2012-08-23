class CreateTransactionDetails < ActiveRecord::Migration
  def change
    create_table :transaction_details do |t|
      t.integer :transaction_id
      t.integer :service_id
      t.integer :price_type

      t.timestamps
    end
  end
end
