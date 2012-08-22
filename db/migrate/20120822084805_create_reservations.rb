class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :number_people
      t.datetime :datetime
      t.string :name

      t.timestamps
    end
  end
end
