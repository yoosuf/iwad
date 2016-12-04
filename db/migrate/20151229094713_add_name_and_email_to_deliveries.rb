class AddNameAndEmailToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :name, :string
    add_column :deliveries, :email, :string
  end
end
