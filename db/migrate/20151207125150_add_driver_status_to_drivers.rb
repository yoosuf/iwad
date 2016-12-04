class AddDriverStatusToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :status, :boolean, defautl: false
    add_column :drivers, :token, :string
  end
end
