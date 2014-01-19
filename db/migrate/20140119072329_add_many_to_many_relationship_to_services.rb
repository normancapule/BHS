class AddManyToManyRelationshipToServices < ActiveRecord::Migration
  def change
    create_table :package_services, id: false do |t|
      t.integer :package_id
      t.integer :service_id
    end
    add_index :package_services, :package_id
    add_index :package_services, :service_id
    remove_column :services, :service_id
  end
end
