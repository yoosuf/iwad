class AddNewMoreDoorNumbers < ActiveRecord::Migration
  def change
    add_column :deliveries, :to_door_number, :string
    add_column :deliveries, :from_door_number, :string
    remove_column :deliveries, :door_number
  end
end
