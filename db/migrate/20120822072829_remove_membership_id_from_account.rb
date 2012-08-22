class RemoveMembershipIdFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :membership_id
  end
end
