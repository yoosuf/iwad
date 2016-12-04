class ChangeFieldTypeStringToDecimalOnDeliveriesTable < ActiveRecord::Migration
  def change
    change_column :deliveries, :cost, :decimal, precision: 10, scale: 2
  end
end
