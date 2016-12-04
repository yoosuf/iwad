class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.string         :token
      t.column         :type , "ENUM('IPHONE', 'ANDROID')"
      t.integer        :user_id
      t.timestamps null: false
    end
  end
end
