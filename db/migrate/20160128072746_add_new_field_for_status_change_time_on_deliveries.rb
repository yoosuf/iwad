class AddNewFieldForStatusChangeTimeOnDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :status_updated_at, :datetime
  end
end
