class CreateDriverLocations < ActiveRecord::Migration
  def change
    create_table :driver_locations do |t|
      t.integer       :driver_id
      t.string        :lat
      t.string        :lon
      t.timestamps null: false
    end
  end
end
