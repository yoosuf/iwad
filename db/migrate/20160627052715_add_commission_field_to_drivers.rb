class AddCommissionFieldToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :commission, :decimal, :precision => 10, :scale => 2, null: true
  end
end
