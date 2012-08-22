class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :firstname
      t.string :lastname
      t.string :nickname
      t.integer :cellphone
      t.text :address
      t.date :birthday
      t.integer :membership_id

      t.timestamps
    end
  end
end
