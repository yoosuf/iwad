class AddNewFieldsForDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivery_contact, :string
    add_column :deliveries, :delivery_number, :string
  end
end
