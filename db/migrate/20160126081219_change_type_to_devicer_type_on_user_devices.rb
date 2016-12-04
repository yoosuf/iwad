class ChangeTypeToDevicerTypeOnUserDevices < ActiveRecord::Migration
  def change
    rename_column :user_devices, :type, :device_type
  end
end
