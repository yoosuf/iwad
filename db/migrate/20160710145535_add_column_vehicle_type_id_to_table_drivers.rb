class AddColumnVehicleTypeIdToTableDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :vehicle_type_id, :integer
  end
end
