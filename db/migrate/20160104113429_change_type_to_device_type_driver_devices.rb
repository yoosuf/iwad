class ChangeTypeToDeviceTypeDriverDevices < ActiveRecord::Migration
  def change
    rename_column :driver_devices, :type, :device_type
  end
end
