class MoveRoleFromUserToAccount < ActiveRecord::Migration
  def up
    remove_column :users, :role_id
    add_column :accounts, :role_id, :integer
  end

  def down
  end
end
