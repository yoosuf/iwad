class AddMinCostToDeliveryVehicles < ActiveRecord::Migration
  def change
    add_column :delivery_vehicles, :min_charge, :string
  end
end
