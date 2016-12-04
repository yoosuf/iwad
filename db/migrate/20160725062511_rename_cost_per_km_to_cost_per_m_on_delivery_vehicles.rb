class RenameCostPerKmToCostPerMOnDeliveryVehicles < ActiveRecord::Migration
  def change
    rename_column :delivery_vehicles, :cost_per_km, :cost_per_mile
  end
end
