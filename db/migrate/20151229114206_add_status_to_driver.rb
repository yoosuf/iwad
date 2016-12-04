class AddStatusToDriver < ActiveRecord::Migration
  def change
    add_column :driver_locations, :driver_status_id, :integer
  end
end
