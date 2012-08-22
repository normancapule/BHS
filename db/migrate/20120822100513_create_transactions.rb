class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :customer_id
      t.float :total_price
      t.integer :therapist_id
      t.text :notes
      t.boolean :paid, :default=>false
      t.integer :type

      t.timestamps
    end
  end
end
