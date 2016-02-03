class CreateBusStop < ActiveRecord::Migration
  def up
    create_table :bus_stops do |t|
      t.string :rt
      t.string :dir
      t.integer :stpid
      t.string :stpnm
      t.decimal :lat
      t.decimal :lon
    end
  end

  def down
    drop_table :bus_stops
  end
end
