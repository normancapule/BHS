class RenameServiceTypeAttributeOfService < ActiveRecord::Migration
  def change
    rename_column :services, :service_type, :service_type_id
  end
end
