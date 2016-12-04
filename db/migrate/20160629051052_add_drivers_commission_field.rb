class AddDriversCommissionField < ActiveRecord::Migration
  def change
    add_column :deliveries, :drivers_commission, :decimal, :precision => 10, :scale => 2, null: true
  end
end
