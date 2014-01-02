class CreateDataStreams < ActiveRecord::Migration
  def change
    create_table :data_streams do |t|
      t.integer :client_count
      t.date :stream_date
      t.decimal :gross, precision: 8, scale: 2
      t.decimal :net, precision: 8, scale: 2
      t.decimal :expenses, precision: 8, scale: 2
      t.timestamps
    end
  end
end
