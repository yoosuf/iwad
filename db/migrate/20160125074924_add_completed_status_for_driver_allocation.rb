class AddCompletedStatusForDriverAllocation < ActiveRecord::Migration
  def change
    add_column :driver_allocations, :completed, :integer,  default: 0
  end
end
