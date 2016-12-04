class ChangeDefaultValueOnPrice < ActiveRecord::Migration
  def change

    change_column :deliveries, :cost, :decimal, :precision => 10, :scale => 2, :default => '0'
    change_column :deliveries, :drivers_commission, :decimal, :precision => 10, :scale => 2, :default => '0'
    change_column :drivers, :commission, :decimal, :precision => 10, :scale => 2,  :default => '0'

  end
end
