class ChangeCostFieldFromDelimalTostringOnOrders < ActiveRecord::Migration
  def change
    change_column :deliveries, :cost, :string
  end
end
