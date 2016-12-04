class AddDriverIdToDriverDevices < ActiveRecord::Migration
  def change
    add_column :driver_devices, :driver_id, :integer
  end
end
