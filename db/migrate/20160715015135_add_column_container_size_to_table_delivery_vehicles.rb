class AddColumnContainerSizeToTableDeliveryVehicles < ActiveRecord::Migration
  def change
    add_column :delivery_vehicles, :container_size, :integer
  end
end
