class AddServiceIdToService < ActiveRecord::Migration
  def change
    add_column :services, :mytype, :string, default: "service"
    add_column :services, :service_id, :integer
    add_index :services, :service_id
  end
end
