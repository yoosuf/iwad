class CreateDeliveryVehicles < ActiveRecord::Migration
  def change
    create_table :delivery_vehicles do |t|
      t.string      :name
      t.float       :cost_per_km
      t.string			:description
      t.timestamps null: false
    end
  end
end
