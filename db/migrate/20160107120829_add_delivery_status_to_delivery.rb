class AddDeliveryStatusToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivery_status_id, :integer
  end
end
