class ChangeDefaultValueForStatus < ActiveRecord::Migration
  def change
    change_column :drivers, :status, :boolean, :null => false, :default =>0
  end
end
