class AddMoreFieldsToDeliveryVehicles < ActiveRecord::Migration
  def change
    add_column :delivery_vehicles, :vehicle_type_id, :integer
    add_column :delivery_vehicles, :payload, :string
    add_column :delivery_vehicles, :load_space, :string
  end
end
