class CreateDriverDevices < ActiveRecord::Migration
  def change
    create_table :driver_devices do |t|
      t.string         :token
      t.column         :type , "ENUM('IPHONE', 'ANDROID')"
      t.timestamps null: false
    end
  end
end
