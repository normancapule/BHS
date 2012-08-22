class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :account_id
      t.integer :card_number

      t.timestamps
    end
  end
end
