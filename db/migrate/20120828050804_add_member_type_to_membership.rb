class AddMemberTypeToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :member_type, :integer
  end
end
