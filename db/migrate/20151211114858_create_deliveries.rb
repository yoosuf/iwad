class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.datetime        :delivery_date
      t.string          :from_location
      t.string          :from_lat
      t.string          :from_lon
      t.string          :to_location
      t.string          :to_lat
      t.string          :to_lon
      t.integer         :delivery_vehicle_id
      t.integer         :promocode_id
      t.float           :cost
      t.timestamps null: false
    end
  end
end
