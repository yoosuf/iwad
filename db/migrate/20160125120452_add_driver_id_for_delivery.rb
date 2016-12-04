class AddDriverIdForDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :driver_id, :integer,  default: 0
  end
end
