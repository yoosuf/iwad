class RenameColVehicleTypeIdToDeliveryVehicleId < ActiveRecord::Migration
  def change
    rename_column :drivers, :vehicle_type_id, :delivery_vehicle_id
  end
end
