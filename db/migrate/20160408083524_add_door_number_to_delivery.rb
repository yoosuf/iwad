class AddDoorNumberToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :door_number, :string
  end
end
