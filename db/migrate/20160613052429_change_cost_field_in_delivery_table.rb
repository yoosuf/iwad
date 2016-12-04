class ChangeCostFieldInDeliveryTable < ActiveRecord::Migration
  def up
    change_column :deliveries, :cost, :decimal, :precision => 10, :scale => 2, null: true
  end

  def down
    change_column :deliveries, :cost, :float
  end
end
