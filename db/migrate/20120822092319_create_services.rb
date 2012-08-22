class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :type
      t.float :member_price_morn
      t.float :member_price_eve
      t.float :regular_price

      t.timestamps
    end
  end
end
