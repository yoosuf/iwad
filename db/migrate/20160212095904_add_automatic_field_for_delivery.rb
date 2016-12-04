class AddAutomaticFieldForDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :manual, :integer,  default: 0
  end
end
